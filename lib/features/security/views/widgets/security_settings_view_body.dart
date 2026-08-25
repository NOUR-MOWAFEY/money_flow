import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_cubit.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_state.dart';
import 'package:money_flow/features/security/views/widgets/security_authentication_section.dart';
import 'package:money_flow/features/security/views/widgets/security_notice_card.dart';
import 'package:money_flow/features/security/views/widgets/security_pin_section.dart';

class SecuritySettingsViewBody extends StatelessWidget {
  const SecuritySettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecuritySettingsCubit, SecuritySettingsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CustomLoading());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
            vertical: 16,
          ),
          children: [
            SecurityAuthenticationSection(state: state),
            const SizedBox(height: 28),
            SecurityPinSection(state: state),
            const SizedBox(height: 32),
            const SecurityNoticeCard(),
          ],
        );
      },
    );
  }
}
