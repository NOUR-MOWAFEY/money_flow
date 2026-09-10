import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/view_model/reset_cubit/reset_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/check_list_tile.dart';

class ResetChecklist extends StatelessWidget {
  const ResetChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ResetCubit>();

    return Column(
      children: [
        ChecklistTile(
          value: cubit.selectAllValue,
          tristate: true,
          onChanged: cubit.toggleSelectAll,
          title: 'Select all',
          titleStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Divider(height: 8, indent: 8, endIndent: 8),
        ...BackupType.values.map((type) {
          final isSelected = cubit.isSelected(type);
          final count = type.count;

          return ChecklistTile(
            value: isSelected,
            onChanged: (value) => cubit.toggleItem(type, value),
            title: type.title,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.error.withAlpha(30)
                    : AppColors.grey.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.error : AppColors.grey,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
