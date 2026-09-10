import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/notice_card.dart';
import 'package:money_flow/features/data_management/view_model/restore_cubit/restore_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_file_picker_card.dart';

class RestoreEmptyState extends StatelessWidget {
  const RestoreEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestoreCubit>();
    final isLoadingFile = context.select<RestoreCubit, bool>(
      (c) => c.state is RestoreFileLoading,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.topSpace),
          const CustomText(
            'Restore from Backup',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          CustomText(
            'Import transactions, categories, budgets, and settings from a previously saved JSON file.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.text.withAlpha(150),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          RestoreFilePickerCard(
            onTap: cubit.pickFile,
            isLoading: isLoadingFile,
          ),
          const SizedBox(height: 24),
          const NoticeCard(
            icon: Icons.shield_outlined,
            title: 'Safe & Offline',
            description:
                'Restoring data processes your JSON backup file completely on your device. No data is uploaded or transmitted externally.',
          ),
          const SizedBox(height: 16),
          const NoticeCard(
            icon: Icons.info_outline,
            title: 'Flexible Options',
            description:
                'Once a backup file is chosen, you can preview all records, select specific items, and choose between merging or replacing existing data.',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
