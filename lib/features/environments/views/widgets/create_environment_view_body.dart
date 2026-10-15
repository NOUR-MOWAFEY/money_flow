import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/notice_card.dart';
import 'package:money_flow/features/environments/view_models/create_environment_cubit/create_environment_cubit.dart';
import 'package:money_flow/features/environments/view_models/create_environment_cubit/create_environment_state.dart';
import 'package:money_flow/features/environments/views/widgets/create_environment_amount_field.dart';
import 'package:money_flow/features/environments/views/widgets/create_environment_button.dart';
import 'package:money_flow/features/environments/views/widgets/create_environment_deduct_switch.dart';
import 'package:money_flow/features/environments/views/widgets/create_environment_desc_field.dart';
import 'package:money_flow/features/environments/views/widgets/create_environment_icon_color_pickers.dart';
import 'package:money_flow/features/environments/views/widgets/create_environment_name_field.dart';

class CreateEnvironmentViewBody extends StatelessWidget {
  const CreateEnvironmentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';

    return BlocConsumer<CreateEnvironmentCubit, CreateEnvironmentState>(
      listener: (context, state) {
        if (state is CreateEnvironmentSuccess) {
          ShowToastification.success(
            context,
            state.isEditing
                ? 'Environment "${state.environmentName}" updated successfully'
                : 'Environment "${state.environmentName}" created successfully',
          );
          Navigator.of(context).pop();
        } else if (state is CreateEnvironmentFailure) {
          ShowToastification.failure(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreateEnvironmentCubit>();

        return SafeArea(
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.viewPadding,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateEnvironmentNameField(controller: cubit.nameController),
                  const SizedBox(height: 20),
                  CreateEnvironmentDescField(controller: cubit.descController),
                  const SizedBox(height: 20),
                  CreateEnvironmentAmountField(
                    controller: cubit.amountController,
                    currency: currency,
                  ),
                  const SizedBox(height: 24),
                  if (cubit.isEditing)
                    NoticeCard(
                      icon: cubit.deductFromMain
                          ? Icons.info_outline_rounded
                          : Icons.warning_amber_rounded,
                      accentColor: cubit.deductFromMain
                          ? const Color(0xFF26A69A)
                          : const Color(0xFFFFB74D),
                      title: cubit.deductFromMain
                          ? 'Deducted from Main Balance'
                          : 'Not Deducted from Main Balance',
                      description: cubit.deductFromMain
                          ? 'The initial funds for this environment were deducted from your main ledger balance.'
                          : 'This environment was created without deducting initial funds from your main balance.',
                    )
                  else
                    CreateEnvironmentDeductSwitch(
                      value: cubit.deductFromMain,
                      onChanged: cubit.toggleDeductFromMain,
                    ),
                  const SizedBox(height: 24),
                  CreateEnvironmentIconColorPickers(
                    selectedIcon: cubit.selectedIcon,
                    selectedColor: cubit.selectedColor,
                    onPickIcon: () => cubit.pickIcon(context),
                    onPickColor: () => cubit.pickColor(context),
                  ),
                  const SizedBox(height: 36),
                  CreateEnvironmentButton(
                    title: cubit.isEditing
                        ? 'Save Changes'
                        : 'Create Environment',
                    color: cubit.selectedColor,
                    onTap: cubit.saveEnvironment,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
