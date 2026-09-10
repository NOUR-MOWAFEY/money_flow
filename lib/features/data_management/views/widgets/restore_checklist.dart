import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/data_management/data/models/backup_payload.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/views/widgets/check_list_tile.dart';

class RestoreChecklist extends StatelessWidget {
  final BackupDataPayload payload;
  final Set<BackupType> selectedTypes;
  final ValueChanged<bool?> onToggleSelectAll;
  final void Function(BackupType type, bool? value) onToggleItem;

  const RestoreChecklist({
    super.key,
    required this.payload,
    required this.selectedTypes,
    required this.onToggleSelectAll,
    required this.onToggleItem,
  });

  bool get _allSelected => selectedTypes.length == payload.availableTypes.length;

  bool get _noneSelected => selectedTypes.isEmpty;

  bool? get _selectAllValue {
    if (_allSelected) return true;
    if (_noneSelected) return false;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChecklistTile(
          value: _selectAllValue,
          tristate: true,
          onChanged: onToggleSelectAll,
          title: 'Select all',
          titleStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Divider(height: 8, indent: 8, endIndent: 8),
        ...payload.availableTypes.map((type) {
          final isSelected = selectedTypes.contains(type);
          final count = payload.countFor(type);

          return ChecklistTile(
            value: isSelected,
            onChanged: (value) => onToggleItem(type, value),
            title: type.title,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withAlpha(35)
                    : AppColors.grey.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.primary : AppColors.grey,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
