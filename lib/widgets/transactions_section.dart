import 'package:flutter/material.dart';
import 'package:money_flow/widgets/transaction_tile.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key, required this.items});

  final List<TransactionTile> items;

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(top: 16),

        sliver: SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ),
    );
  }
}
