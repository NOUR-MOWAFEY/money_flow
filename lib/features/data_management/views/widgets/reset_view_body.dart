import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/notice_card.dart';
import 'package:money_flow/features/data_management/view_model/reset_cubit/reset_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/reset_checklist.dart';
import 'package:money_flow/features/data_management/views/widgets/reset_confirm_dialog.dart';

class ResetViewBody extends StatelessWidget {
  const ResetViewBody({super.key});

  void _onResetPressed(BuildContext context, ResetCubit cubit) {
    if (cubit.noneSelected) {
      ShowToastification.warning(
        context,
        'Please select at least one item to reset.',
      );
      return;
    }

    ResetConfirmDialog.show(
      context,
      itemCount: cubit.selectedItemsCount,
      onConfirm: cubit.resetSelectedData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetCubit, ResetState>(
      listener: (context, state) {
        if (state is ResetSuccess) {
          ShowToastification.success(
            context,
            'Successfully deleted ${state.deletedCount} records.',
          );
          Navigator.pop(context);
        } else if (state is ResetFailure) {
          ShowToastification.failure(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ResetCubit>();
        final isBusy = state is ResetInProgress;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.topSpace),
              const CustomText(
                'What do you want to reset?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const ResetChecklist(),
              const SizedBox(height: 24),
              const NoticeCard(
                icon: Icons.warning_amber_rounded,
                accentColor: AppColors.error,
                title: 'Permanent Action',
                description:
                    'Deleted data cannot be recovered. We strongly recommend exporting a backup before resetting.',
              ),
              const SizedBox(height: 32),
              CustomButton(
                title: 'Reset Selected Data',
                color: AppColors.error,
                onTap: isBusy
                    ? null
                    : () => _onResetPressed(context, cubit),
                child: isBusy
                    ? const Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
