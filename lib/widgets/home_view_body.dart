import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/utils/show_confirmation_dialog.dart';
import 'package:money_flow/widgets/custom_sliver_app_bar.dart';
import 'package:money_flow/widgets/home_view_app_bar.dart';
import 'package:money_flow/widgets/transaction_tile.dart';
import 'package:money_flow/widgets/user_main_info.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 35)),

        // user image + name + reset button
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: UserMainInfo(),
          ),
        ),

        // available balance
        const CustomSliverAppBar(),

        // const SliverToBoxAdapter(child: SizedBox(height: 60)),
        SliverFillRemaining(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
            ),
            child: ValueListenableBuilder(
              valueListenable: HiveService().listenable,
              builder: (context, box, _) {
                var transactions = box.values.toList().reversed.toList();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (context, index) => TransactionTile(
                      onLongPress: () {
                        ShowConfirmationDialog.showConfirmationDialog(
                          context,
                          subtitle:
                              'Are you Sure you want to delete this transaction',
                          onTapNo: () => Navigator.pop(context),
                          onTapYes: () {
                            Navigator.pop(context);
                            HiveService().deleteTransaction(index);
                            BalanceController.updateBalance();
                          },
                        );
                      },
                      isFirstOne: index == 0,
                      isLastOne: index == transactions.length - 1
                          ? true
                          : false,
                      icon: transactions[index].isExpense
                          ? AppCategories.expenseCategories[transactions[index]
                                    .title] ??
                                Icons.error
                          : AppCategories.incomeCategories[transactions[index]
                                    .title] ??
                                Icons.error,
                      title: transactions[index].title,
                      amount:
                          'EGP ${transactions[index].amount.toStringAsFixed(2)}',
                      date: DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 18);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
