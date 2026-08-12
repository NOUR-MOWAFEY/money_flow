import 'package:flutter/material.dart';
import 'package:money_flow/features/home/views/widgets/custom_sliver_app_bar.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_section.dart';
import 'package:money_flow/features/home/views/widgets/user_main_info.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        // user image + name + reset button
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: UserMainInfo(),
          ),
        ),

        // available balance
        CustomSliverAppBar(),

        // transactions list
        TransactionsSection(),
      ],
    );
  }
}
