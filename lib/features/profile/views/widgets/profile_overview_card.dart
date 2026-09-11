import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ProfileOverviewCard extends StatelessWidget {
  const ProfileOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsCount = HiveService.instance.getTransactions().length;
    final budgetsCount = HiveService.instance.getBudgets().length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shield_outlined, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              CustomText(
                'Account & Storage',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _InfoMetric(
                label: 'Transactions',
                value: transactionsCount.toString(),
                icon: Icons.receipt_long_rounded,
              ),
              Container(width: 1, height: 36, color: Colors.white10),
              _InfoMetric(
                label: 'Budgets',
                value: budgetsCount.toString(),
                icon: Icons.pie_chart_outline_rounded,
              ),
              Container(width: 1, height: 36, color: Colors.white10),
              const _InfoMetric(
                label: 'Storage',
                value: 'Local / Hive',
                icon: Icons.storage_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoMetric extends StatelessWidget {
  const _InfoMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.white54),
        const SizedBox(height: 6),
        CustomText(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        CustomText(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white38),
        ),
      ],
    );
  }
}
