import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/category_icon_picker_dialog.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_color_picker_dialog.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/create_environment_cubit/create_environment_state.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class CreateEnvironmentCubit extends Cubit<CreateEnvironmentState> {
  CreateEnvironmentCubit(this.hiveService, {this.environment})
    : super(CreateEnvironmentInitial()) {
    if (environment != null) {
      nameController.text = environment!.name;
      descController.text = environment!.description;
      final amount = environment!.initialAmount;
      amountController.text = amount.truncateToDouble() == amount
          ? amount.toInt().toString()
          : amount.toString();
      selectedColor = Color(environment!.colorValue);
      selectedIcon = AppIcons.icons.firstWhere(
        (icon) => icon.icon.codePoint == environment!.iconCodePoint,
        orElse: () => AppIcons.icons.first,
      );
      deductFromMain = environment!.deductedFromMain;
    }
  }

  final HiveService hiveService;
  final EnvironmentModel? environment;
  bool get isEditing => environment != null;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();

  bool deductFromMain = true;
  Color selectedColor = AppColors.primary;
  CategoryIcon selectedIcon = AppIcons.icons.firstWhere(
    (icon) => icon.icon == Icons.layers_outlined,
    orElse: () => AppIcons.icons.first,
  );

  void selectColor(Color color) {
    selectedColor = color;
    emit(CreateEnvironmentInitial());
  }

  void selectIcon(CategoryIcon icon) {
    selectedIcon = icon;
    emit(CreateEnvironmentInitial());
  }

  void toggleDeductFromMain(bool value) {
    deductFromMain = value;
    emit(CreateEnvironmentInitial());
  }

  Future<void> pickColor(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final pickedColor = await showDialog<Color>(
      context: context,
      builder: (context) => DialogOpenAnimation(
        child: EditCategoryColorPickerDialog(initialColor: selectedColor),
      ),
    );

    if (pickedColor != null) {
      selectColor(pickedColor);
    }
  }

  Future<void> pickIcon(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final pickedIcon = await showDialog<CategoryIcon>(
      context: context,
      builder: (context) => BlocProvider(
        create: (_) {
          final pickerCubit = NewCategoryCubit(HiveService());
          pickerCubit.selectIcon(selectedIcon);
          pickerCubit.resetIconPicker();
          return pickerCubit;
        },
        child: const DialogOpenAnimation(child: CategoryIconPickerDialog()),
      ),
    );

    if (pickedIcon != null) {
      selectIcon(pickedIcon);
    }
  }

  Future<void> saveEnvironment() async {
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    if (name.isEmpty) {
      emit(CreateEnvironmentFailure('Please enter a name'));
      return;
    }

    // 1. Get the double, default to 0.0 if invalid
    final rawAmount = double.tryParse(amountController.text.trim()) ?? 0.0;

    // 2. Format to 2 decimal places and parse back to double
    final amount = double.parse(rawAmount.toStringAsFixed(2));

    if (amount < 0) {
      emit(CreateEnvironmentFailure('Enter a valid positive number'));
      return;
    }

    emit(CreateEnvironmentLoading());
    try {
      final description = descController.text.trim();

      if (isEditing) {
        final env = environment!;
        final diff = amount - env.initialAmount;
        env.name = name;
        env.description = description;
        env.initialAmount = amount;
        env.currentBalance = (env.currentBalance + diff).clamp(
          0.0,
          double.infinity,
        );
        env.colorValue = selectedColor.toARGB32();
        env.iconCodePoint = selectedIcon.icon.codePoint;

        await hiveService.environmentStorage.updateEnvironment(env);
        emit(CreateEnvironmentSuccess(name, isEditing: true));
      } else {
        final env = EnvironmentModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          name: name,
          description: description,
          initialAmount: amount,
          currentBalance: amount,
          createdAt: DateTime.now(),
          colorValue: selectedColor.toARGB32(),
          iconCodePoint: selectedIcon.icon.codePoint,
          deductedFromMain: deductFromMain && amount > 0,
        );

        await hiveService.addEnvironment(env);

        if (deductFromMain && amount > 0) {
          final transaction = TransactionModel(
            title: 'Environment: ${env.name}',
            amount: amount,
            date: DateTime.now(),
            isExpense: true,
            environmentId: env.id,
          );
          await hiveService.transactionStorage.addTransaction(transaction);
        }

        emit(CreateEnvironmentSuccess(name, isEditing: false));
      }
    } catch (_) {
      emit(
        CreateEnvironmentFailure(
          isEditing
              ? 'Failed to update environment'
              : 'Failed to create environment',
        ),
      );
    }
  }

  Future<void> createEnvironment() => saveEnvironment();

  @override
  Future<void> close() {
    nameController.dispose();
    descController.dispose();
    amountController.dispose();
    return super.close();
  }
}
