import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/reports/data/models/category_limit_item.dart';
import 'package:money_flow/features/reports/views/widgets/reports_card.dart';

class CategoryBudgetLimits extends StatelessWidget {
  const CategoryBudgetLimits({
    super.key,
    this.items,
  });

  final List<CategoryLimitItem>? items;

  List<CategoryLimitItem> get _defaultItems => const [
        CategoryLimitItem(
          title: 'Food & Dining',
          icon: Icons.fastfood,
          iconColor: Color(0xFFFF6B35),
          spent: 280,
          limit: 300,
        ),
        CategoryLimitItem(
          title: 'Shopping',
          icon: Icons.shopping_bag,
          iconColor: Color(0xFFE91E8C),
          spent: 195,
          limit: 300,
        ),
        CategoryLimitItem(
          title: 'Groceries',
          icon: Icons.local_grocery_store,
          iconColor: Color(0xFF43A047),
          spent: 120,
          limit: 400,
        ),
        CategoryLimitItem(
          title: 'Entertainment',
          icon: Icons.movie,
          iconColor: Color(0xFF8E24AA),
          spent: 85,
          limit: 100,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final list = (items != null && items!.isNotEmpty) ? items! : _defaultItems;

    return ReportsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(activeCount: list.length),
          const SizedBox(height: 18),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: 18),
            itemBuilder: (_, index) => _CategoryLimitTile(item: list[index]),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.activeCount});
  final int activeCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText(
          'Category Limits',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        CustomText(
          '$activeCount active',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}

class _CategoryLimitTile extends StatelessWidget {
  const _CategoryLimitTile({required this.item});
  final CategoryLimitItem item;

  @override
  Widget build(BuildContext context) {
    final color = item.statusColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _CategoryIcon(icon: item.icon, color: item.iconColor),
            const SizedBox(width: 12),
            Expanded(child: _CategoryInfo(title: item.title, spent: item.spent, limit: item.limit)),
            _PercentageBadge(percentage: item.percentage, color: color),
          ],
        ),
        const SizedBox(height: 10),
        _ProgressBar(progress: item.progress, color: color),
      ],
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.icon, this.color});
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }
}

class _CategoryInfo extends StatelessWidget {
  const _CategoryInfo({
    required this.title,
    required this.spent,
    required this.limit,
  });

  final String title;
  final double spent;
  final double limit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        CustomText(
          '\$${spent.toStringAsFixed(0)} / \$${limit.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

class _PercentageBadge extends StatelessWidget {
  const _PercentageBadge({required this.percentage, required this.color});
  final int percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: CustomText(
        '$percentage%',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
