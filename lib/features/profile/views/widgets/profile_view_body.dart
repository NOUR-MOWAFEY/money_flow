import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/features/profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:money_flow/features/profile/view_model/profile_cubit/profile_state.dart';
import 'package:money_flow/features/profile/views/widgets/profile_avatar.dart';
import 'package:money_flow/features/profile/views/widgets/profile_currency_tile.dart';
import 'package:money_flow/features/profile/views/widgets/profile_image_picker_sheet.dart';
import 'package:money_flow/features/profile/views/widgets/profile_name_field.dart';
import 'package:money_flow/features/profile/views/widgets/profile_overview_card.dart';
import 'package:money_flow/features/profile/views/widgets/profile_save_button.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileCubit>();
    _nameController = TextEditingController(text: cubit.state.name);
    _nameController.addListener(() {
      if (_nameController.text != cubit.state.name) {
        cubit.updateName(_nameController.text);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (prev, current) =>
          prev.isSaved != current.isSaved ||
          prev.errorMessage != current.errorMessage ||
          (prev.name != current.name && current.name != _nameController.text),
      listener: (context, state) {
        if (state.errorMessage != null) {
          ShowToastification.failure(context, state.errorMessage!);
        }
        if (state.isSaved) {
          ShowToastification.success(context, 'Profile updated successfully!');
          Navigator.pop(context);
        }
        if (state.name != _nameController.text && !FocusScope.of(context).hasFocus) {
          _nameController.text = state.name;
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final cubit = context.read<ProfileCubit>();

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
            vertical: 16,
          ),
          children: [
            const SizedBox(height: 12),
            ProfileAvatar(
              imagePath: state.imagePath,
              name: state.name,
              onTap: () => ProfileImagePickerSheet.show(
                context,
                hasImage:
                    state.imagePath != null && state.imagePath!.isNotEmpty,
                onPickImage: (source) => cubit.pickImage(source),
                onRemoveImage: () => cubit.removeImage(),
              ),
            ),
            const SizedBox(height: 28),
            ProfileNameField(
              controller: _nameController,
              onChanged: (name) => cubit.updateName(name),
            ),
            const SizedBox(height: 20),
            ProfileCurrencyTile(currencyCode: state.defaultCurrency),
            const SizedBox(height: 20),
            const ProfileOverviewCard(),
            const SizedBox(height: 32),
            ProfileSaveButton(
              isSaving: state.isSaving,
              onTap: () {
                cubit.updateName(_nameController.text);
                cubit.saveProfile();
              },
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
