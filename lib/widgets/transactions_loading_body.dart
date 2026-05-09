import 'package:flutter/material.dart';

class TransactionsLoadingBody extends StatelessWidget {
  const TransactionsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
