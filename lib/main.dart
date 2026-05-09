import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/constants/app_theme.dart';
import 'package:money_flow/cubits/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/views/home_view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  await Hive.openBox<TransactionModel>('transactions');
  await Hive.openBox('user');
  runApp(const MoneyFlowApp());
}

class MoneyFlowApp extends StatelessWidget {
  const MoneyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsCubit(HiveService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.mainTheme(),
        home: const HomeView(),
      ),
    );
  }
}
