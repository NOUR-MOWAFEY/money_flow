import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/views/add_transaction_view.dart';
import 'package:money_flow/widgets/analytics_body.dart';
import 'package:money_flow/widgets/floating_bottom_nav_bar.dart';
import 'package:money_flow/widgets/home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
            bottom: false,
            child: isHome ? HomeBody() : AnalyticsBody(),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: FloatingBottomNavBar(
            addButtonIconColor: isHome
                ? AppColors.white
                : AppColors.primaryColor,
            addButtonColor: isHome ? AppColors.primaryColor : AppColors.white,
            addButtonOnPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransactionView()),
              );
            },
            indexOneOnPressed: () {
              setState(() {
                isHome = false;
              });
            },
            indexZeroOnPressed: () {
              setState(() {
                isHome = true;
              });
            },
          ),
        ),
      ],
    );
  }
}
