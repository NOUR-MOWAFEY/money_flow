import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/date_formatter.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/view_model/recurring_transactions_cubit/recurring_transactions_cubit.dart';
import 'package:money_flow/features/settings/views/edit_recurring_transactions_view.dart';

class RecurringTransactionTile extends StatelessWidget {
  const RecurringTransactionTile({
    super.key,
    required this.recurringTransaction,
  });

  final RecurringTransactionModel recurringTransaction;

  bool get _isExpense => recurringTransaction.type == CategoryType.expenses;

  @override
  Widget build(BuildContext context) {
    final category = getCategory(
      recurringTransaction.categoryTitle ?? recurringTransaction.title,
      _isExpense,
      HiveService.instance,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditRecurringTransactionsView(
                recurringTransaction: recurringTransaction,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.black1,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: recurringTransaction.isActive
                    ? category.color.withAlpha(40)
                    : Colors.white.withAlpha(10),
                width: 2,
              ),
            ),
            child: Opacity(
              opacity: recurringTransaction.isActive ? 1 : 0.5,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .start,
                    children: [
                      _CategoryIcon(category: category),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _TileInfo(
                          category: category,
                          recurringTransaction: recurringTransaction,
                        ),
                      ),

                      const SizedBox(width: 10),

                      _Amount(
                        recurringTransaction: recurringTransaction,
                        isExpense: _isExpense,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      _DatesSection(recurringTransaction: recurringTransaction),

                      const Spacer(),

                      FlutterSwitch(
                        height: 30,
                        width: 58,
                        toggleSize: 23,

                        activeColor: AppColors.primary,

                        value: recurringTransaction.isActive,
                        onToggle: (_) {
                          context
                              .read<RecurringTransactionsCubit>()
                              .toggleStatus(recurringTransaction);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DatesSection extends StatelessWidget {
  const _DatesSection({required this.recurringTransaction});

  final RecurringTransactionModel recurringTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        _DateLabel(
          icon: Icons.event_outlined,
          prefix: 'From: ',
          text: DateFormatter.ddmy(recurringTransaction.startDate),
        ),

        const SizedBox(height: 6),

        _DateLabel(
          icon: Icons.event_busy_outlined,
          prefix: 'Until: ',
          text: recurringTransaction.endDate != null
              ? DateFormatter.ddmy(recurringTransaction.endDate!)
              : 'No end date',
        ),
      ],
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: category.color.categoryContainerColor,
      ),
      child: Icon(
        category.icon,
        color: category.color.categoryIconColor,
        size: 22,
      ),
    );
  }
}

class _TileInfo extends StatelessWidget {
  const _TileInfo({required this.category, required this.recurringTransaction});

  final CategoryModel category;
  final RecurringTransactionModel recurringTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          category.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          maxLines: 1,
        ),

        const SizedBox(height: 6),

        _FrequencyBadge(
          label: StringUtils.capitalizeFirstLetter(
            recurringTransaction.frequency.name,
          ),
          color: category.color,
        ),
      ],
    );
  }
}

class _FrequencyBadge extends StatelessWidget {
  const _FrequencyBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(60), width: 0.6),
      ),
      child: CustomText(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({required this.icon, required this.text, this.prefix});

  final IconData icon;
  final String text;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.grey),
        const SizedBox(width: 3),
        CustomText(
          prefix != null ? '$prefix $text' : text,
          style: const TextStyle(fontSize: 12, color: AppColors.grey),
        ),
      ],
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({required this.recurringTransaction, required this.isExpense});

  final RecurringTransactionModel recurringTransaction;
  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    final amountPrefix = isExpense ? '-' : '+';
    final amountColor = isExpense ? AppColors.error : AppColors.primary;

    return CustomText(
      '$amountPrefix EGP ${recurringTransaction.amount.toStringAsFixed(0)}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: amountColor,
      ),
    );
  }
}
