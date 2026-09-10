import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/data_management/data/models/restore_mode.dart';

class RestoreModeSelector extends StatelessWidget {
  final RestoreMode currentMode;
  final ValueChanged<RestoreMode> onModeChanged;
  final bool isBusy;

  const RestoreModeSelector({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
    this.isBusy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Restore Mode',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildModeOption(
          mode: RestoreMode.merge,
          title: 'Merge with Existing Data',
          subtitle:
              'Keep current data and add records from backup without deleting anything.',
          icon: Icons.merge_type_rounded,
          isSelected: currentMode == RestoreMode.merge,
        ),
        const SizedBox(height: 10),
        _buildModeOption(
          mode: RestoreMode.replace,
          title: 'Replace Existing Data',
          subtitle:
              'Erase current records for selected types and replace them with backup items.',
          icon: Icons.swap_horiz_rounded,
          isSelected: currentMode == RestoreMode.replace,
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildModeOption({
    required RestoreMode mode,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    bool isDestructive = false,
  }) {
    final activeColor = isDestructive && isSelected
        ? AppColors.error
        : AppColors.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isBusy ? null : () => onModeChanged(mode),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected ? activeColor.withAlpha(25) : AppColors.black1,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? activeColor : AppColors.grey.withAlpha(40),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? activeColor : AppColors.grey,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeColor,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 17, color: activeColor),
                        const SizedBox(width: 6),
                        CustomText(
                          title,
                          color: isSelected ? activeColor : AppColors.text,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isDestructive) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error.withAlpha(30),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const CustomText(
                              'Caution',
                              color: AppColors.error,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.text.withAlpha(140),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
