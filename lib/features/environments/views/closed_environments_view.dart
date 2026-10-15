import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/environments/views/widgets/closed_environments_view_body.dart';

class ClosedEnvironmentsView extends StatelessWidget {
  const ClosedEnvironmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Closed Environments'),
      body: ClosedEnvironmentsViewBody(),
    );
  }
}
