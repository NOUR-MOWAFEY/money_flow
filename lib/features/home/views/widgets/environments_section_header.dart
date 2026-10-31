import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/active_count_badge.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class EnvironmentsSectionHeader extends StatelessWidget {
  const EnvironmentsSectionHeader({
    super.key,
    required this.activeCount,
    required this.onManage,
  });

  final int activeCount;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CustomText(
              'Environments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            ActiveCountBadge(
              count: activeCount,
              color: AppColors.primary,
              showIcon: false,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: onManage,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(Icons.tune_rounded, size: 16),
          label: const Text(
            'Manage',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
