import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/settings/view_model/recurring_transactions_cubit/recurring_transactions_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_transactions_list_view.dart';

class RecurringTransactionsViewBody extends StatelessWidget {
  const RecurringTransactionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),
      child:
          BlocBuilder<RecurringTransactionsCubit, RecurringTransactionsState>(
            builder: (context, state) {
              if (state is RecurringTransactionsLoading) {
                return const CustomLoading();
              }

              if (state is RecurringTransactionsFailure) {
                return Center(
                  child: CustomText(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (state is RecurringTransactionsLoaded) {
                return RecurringTransactionsListView(
                  active: state.active,
                  inactive: state.inactive,
                );
              }

              return const SizedBox.shrink();
            },
          ),
    );
  }
}
