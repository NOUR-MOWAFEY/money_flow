import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/features/data_management/view_model/restore_cubit/restore_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_content_view.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_empty_state.dart';

class RestoreViewBody extends StatelessWidget {
  const RestoreViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestoreCubit, RestoreState>(
      listener: (context, state) {
        if (state is RestoreSuccess) {
          ShowToastification.success(
            context,
            'Successfully restored ${state.restoredCount} items!',
          );
          Navigator.pop(context);
        } else if (state is RestoreFailure) {
          ShowToastification.failure(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        final isLoaded = state is RestoreFileLoaded ||
            state is RestoreInProgress ||
            (state is RestoreFailure && state.payload != null);

        if (isLoaded) {
          return const RestoreContentView();
        }
        return const RestoreEmptyState();
      },
    );
  }
}
