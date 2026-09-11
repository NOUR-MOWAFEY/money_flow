import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:money_flow/features/profile/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: const Scaffold(
        appBar: CustomAppBar(title: 'Edit Profile'),
        body: SafeArea(child: ProfileViewBody()),
      ),
    );
  }
}
