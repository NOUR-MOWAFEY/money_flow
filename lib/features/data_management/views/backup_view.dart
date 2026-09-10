import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/data_management/view_model/backup_cubit/backup_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/backup_view_body.dart';

class BackupView extends StatelessWidget {
  const BackupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BackupCubit(),
      child: const Scaffold(
        appBar: CustomAppBar(title: 'Backup'),
        body: BackupViewBody(),
      ),
    );
  }
}
