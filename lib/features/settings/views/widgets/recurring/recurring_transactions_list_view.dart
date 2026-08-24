import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_animated_tile.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_section_header.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_transactions_empty_list_view.dart';

class RecurringTransactionsListView extends StatelessWidget {
  const RecurringTransactionsListView({
    super.key,
    required this.active,
    required this.inactive,
  });

  final List<RecurringTransactionModel> active;
  final List<RecurringTransactionModel> inactive;

  @override
  Widget build(BuildContext context) {
    if (active.isEmpty && inactive.isEmpty) {
      return const RecurringTransactionsEmptyListView();
    }

    return CustomScrollView(
      slivers: [
        // ── Active ──────────────────────────────────────────────
        if (active.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: RecurringSectionHeader(
              label: 'Active',
              count: active.length,
              color: AppColors.primary,
              icon: Icons.check_circle_rounded,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => RecurringAnimatedTile(
                key: ValueKey(active[index].id),
                recurringTransaction: active[index],
              ),
              childCount: active.length,
            ),
          ),
        ],

        // gap between sections
        if (active.isNotEmpty && inactive.isNotEmpty)
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // ── Inactive ─────────────────────────────────────────────
        if (inactive.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: RecurringSectionHeader(
              label: 'Inactive',
              count: inactive.length,
              color: AppColors.grey,
              icon: Icons.pause_circle_outline_rounded,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => RecurringAnimatedTile(
                key: ValueKey(inactive[index].id),
                recurringTransaction: inactive[index],
              ),
              childCount: inactive.length,
            ),
          ),
        ],

        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimensions.viewBottomSpace),
        ),
      ],
    );
  }
}
