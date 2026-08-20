import 'package:flutter/material.dart';
import 'package:money_flow/features/home/views/widgets/home_view_body.dart';
import 'package:money_flow/features/transactions/views/add_transaction_view.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_floating_action_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: AppColors.primary,
      floatingActionButton: CustomFloatingActionButton(
        view: AddTransactionView(),
      ),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
