import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/home/views/widgets/custom_sliver_app_bar.dart';
import 'package:money_flow/features/home/views/widgets/user_main_info.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverToBoxAdapter(child: Container(height: 24, color: AppColors.bg)),

        // user image + name + reset button
        const SliverToBoxAdapter(child: UserMainInfo()),

        // available balance
        const CustomSliverAppBar(),

        // transactions list
        const TransactionsSection(),
      ],
    );
  }
}

class MoneySummaryCard extends StatelessWidget {
  const MoneySummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 145,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withValues(alpha: 0.80), AppColors.secondaryColor],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Stack(
          children: [
            // Decorative circle
            Positioned(
              right: -25,
              top: -30,
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.08),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 20),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Text(
                  amount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
