import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/widgets/custom_bar_chart.dart';
import 'package:money_flow/widgets/custom_line_chart.dart';
import 'package:money_flow/widgets/home_view_header.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AnalyticsBody extends StatefulWidget {
  const AnalyticsBody({super.key});

  @override
  State<AnalyticsBody> createState() => _AnalyticsBodyState();
}

class _AnalyticsBodyState extends State<AnalyticsBody> {
  late List<TransactionModel> transactions;
  late List<TransactionModel> expenses;
  late List<TransactionModel> income;
  late List<double> amounts;
  int selectedIndex = 0;

  @override
  void initState() {
    transactions = HiveService().getTransactions();

    expenses = HiveService.getExpenses(transactions);
    if (expenses.length > 7) {
      expenses = expenses.sublist(0, 7);
    }

    income = HiveService.getIncome(transactions);
    if (income.length > 7) {
      income = income.sublist(0, 7);
    }

    amounts = HiveService.getAmounts(expenses);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentList = selectedIndex == 0 ? expenses : income;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HomeViewHeader(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ToggleSwitch(
            activeBgColor: [AppColors.transparentWhite],
            activeFgColor: AppColors.black,
            inactiveBgColor: AppColors.secondaryColor,
            minWidth: double.infinity,
            customTextStyles: [TextStyle(fontWeight: FontWeight.bold)],
            initialLabelIndex: selectedIndex,
            totalSwitches: 2,
            labels: ['Expenses', 'Income'],
            onToggle: (index) {
              setState(() {
                selectedIndex = index!;
                var items = selectedIndex == 0 ? expenses : income;
                amounts = HiveService.getAmounts(items);
              });
            },
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.only(top: 20),
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.transparentWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomBarChart(
            values: amounts,
            expenses: currentList,
            title: selectedIndex == 0 ? 'Expenses' : 'Income',
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.all(16),
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.transparentWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomLineChart(
            values: amounts,
            expenses: currentList,
            title: selectedIndex == 0 ? 'Expenses Trend' : 'Income Trend',
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
