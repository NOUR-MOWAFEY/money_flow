import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/view_model/backup_cubit/backup_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/check_list_tile.dart';

class BackupChecklist extends StatelessWidget {
  const BackupChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BackupCubit>();

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
            trailing: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
