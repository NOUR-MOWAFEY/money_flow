import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/widgets/transaction_tile.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) => TransactionTile(
                  isLastOne: index == transactions.length - 1 ? true : false,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
