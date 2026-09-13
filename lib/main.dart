import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/constants/app_theme.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/services/recurring_processor_service.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';
import 'package:money_flow/features/onboarding/views/onboarding_view.dart';
import 'package:money_flow/features/security/data/services/app_lock_settings_service.dart';
import 'package:money_flow/features/security/data/services/biometric_service.dart';
import 'package:money_flow/features/security/data/services/pin_service.dart';
import 'package:money_flow/features/security/view_model/app_lock_cubit/app_lock_cubit.dart';
import 'package:money_flow/features/security/views/app_lock_gate.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/main_nav_view.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeHive();
  await RecurringProcessorService.instance.processDueRecurringTransactions(
    HiveService.instance,
  );
  runApp(const MoneyFlowApp());
}

class MoneyFlowApp extends StatelessWidget {
  const MoneyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TransactionsCubit(HiveService())..getAllTransactions(),
        ),
        BlocProvider(
          create: (context) => AppLockCubit(
            pinService: PinService(),
            biometricService: BiometricService(),
            settingsService: AppLockSettingsService(),
          ),
        ),
        BlocProvider(create: (context) => BalanceVisibilityCubit()),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
          title: 'Money Flow',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.mainTheme(),
          home: HiveService.isFirstTime
              ? const OnboardingView()
              : const AppLockGate(child: MainNavView()),
        ),
      ),
    );
  }
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();
  HiveService.registerAdapters();
  await AppLockSettingsService.init();
  await HiveService.openBoxes();
}
