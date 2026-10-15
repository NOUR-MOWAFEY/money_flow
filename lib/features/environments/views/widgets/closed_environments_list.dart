import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/environments/views/environment_details_view.dart';
import 'package:money_flow/features/environments/views/widgets/environment_card.dart';

class ClosedEnvironmentsList extends StatelessWidget {
  const ClosedEnvironmentsList({
    super.key,
    required this.closedEnvironments,
    this.onLongPressEnvironment,
  });

  final List<EnvironmentModel> closedEnvironments;
  final ValueChanged<EnvironmentModel>? onLongPressEnvironment;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
        vertical: 16,
      ),
      itemCount: closedEnvironments.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final env = closedEnvironments[index];
        return EnvironmentCard(
          environment: env,
          onTap: () {
            final envsCubit = context.read<EnvironmentsCubit>();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: envsCubit,
                  child: EnvironmentDetailsView(
                    environmentId: env.id,
                  ),
                ),
              ),
            );
          },
          onLongPress: onLongPressEnvironment != null
              ? () => onLongPressEnvironment!(env)
              : null,
        );
      },
    );
  }
}
