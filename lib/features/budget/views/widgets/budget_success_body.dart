import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/data/models/budget_limit_item.dart';
import 'package:money_flow/features/budget/views/edit_budget_view.dart';
import 'package:money_flow/features/budget/views/widgets/budget_limit_tile.dart';

class BudgetSuccessBody extends StatelessWidget {
  const BudgetSuccessBody({super.key, required this.items});

  final List<BudgetLimitItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height - 280,
        child: const Center(
          child: CustomText(
            'No budgets yet.\nTap + to add your first limit.',
            style: TextStyle(fontSize: 15, color: Colors.white54),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 18),
      itemBuilder: (context, index) {
        final item = items[index];
        return BudgetLimitTile(
          item: item,
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => EditBudgetView(budget: item.budget),
              ),
            );
          },
        );
      },
    );
  }
}
