import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/notice_card.dart';
import 'package:money_flow/features/data_management/view_model/backup_cubit/backup_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/backup_checklist.dart';
import 'package:money_flow/features/data_management/views/widgets/backup_export_button.dart';

class BackupViewBody extends StatelessWidget {
  const BackupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BackupCubit, BackupState>(
      listener: (context, state) {
        if (state is BackupSaveSuccess) {
          ShowToastification.success(
            context,
            'Backup saved to device successfully!',
          );
        } else if (state is BackupExportSuccess) {
          ShowToastification.success(
            context,
            'Backup file shared successfully!',
          );
        } else if (state is BackupExportFailure) {
          ShowToastification.failure(context, state.errorMessage);
        }
      },
      child: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.viewPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppDimensions.topSpace),
            CustomText(
              'What do you want to backup?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            BackupChecklist(),
            SizedBox(height: 24),
            NoticeCard(
              icon: Icons.shield_outlined,
              title: 'Safe & Offline',
              description:
                  'Your backup is generated directly on your device as a JSON file. No data is sent to external servers.',
            ),
            SizedBox(height: 32),
            BackupExportButton(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
