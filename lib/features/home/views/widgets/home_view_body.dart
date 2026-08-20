import 'package:flutter/material.dart';
import 'package:money_flow/features/home/views/widgets/custom_sliver_app_bar.dart';
import 'package:money_flow/features/home/views/widgets/user_main_info.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        // user image + name + reset button
        SliverToBoxAdapter(child: UserMainInfo()),

        // available balance
        CustomSliverAppBar(),

        SliverToBoxAdapter(child: SizedBox(height: 8)),

        // transactions list
        TransactionsSection(),
      ],
    );
  }
}
