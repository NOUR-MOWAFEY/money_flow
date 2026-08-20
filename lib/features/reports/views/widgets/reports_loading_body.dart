import 'package:flutter/material.dart';

class ReportsLoadingBody extends StatelessWidget {
  const ReportsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 320,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
