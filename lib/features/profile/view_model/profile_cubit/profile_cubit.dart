import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/profile/view_model/profile_cubit/profile_state.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({ImagePicker? imagePicker})
    : _picker = imagePicker ?? ImagePicker(),
      super(const ProfileState()) {
    _userSubscription = HiveService.watchUserModel().listen((_) {
      _onUserBoxChanged();
    });
  }

  final ImagePicker _picker;
  StreamSubscription? _userSubscription;

  void loadProfile() {
    emit(state.copyWith(isLoading: true));
    final user = HiveService.getUserModel();
    final name = user?.name.isNotEmpty == true ? user!.name : 'User';
    final imagePath = user?.imagePath;
    final currency = user?.defaultCurrency ?? 'EGP';

    emit(
      state.copyWith(
        user: user,
        name: name,
        imagePath: imagePath,
        defaultCurrency: currency,
        isLoading: false,
      ),
    );
  }

  void _onUserBoxChanged() {
    final user = HiveService.getUserModel();
    if (user != null) {
      emit(
        state.copyWith(
          user: user,
          defaultCurrency: user.defaultCurrency,
        ),
      );
    }
  }

  void updateName(String name) {
    emit(state.copyWith(name: name, clearError: true, isSaved: false));
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );
      if (file != null) {
        emit(
          state.copyWith(
            imagePath: file.path,
            clearError: true,
            isSaved: false,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to pick image. Please check permissions.',
        ),
      );
    }
  }

  void removeImage() {
    emit(state.copyWith(clearImage: true, clearError: true, isSaved: false));
  }

  void updateCurrency(String currency) {
    emit(state.copyWith(defaultCurrency: currency, isSaved: false));
  }

  Future<bool> saveProfile() async {
    final trimmedName = state.name.trim();
    if (trimmedName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter your name'));
      return false;
    }

    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      final existingUser = HiveService.getUserModel();
      if (existingUser != null) {
        await HiveService.updateUserModel(
          name: trimmedName,
          imagePath: state.imagePath,
          defaultCurrency: state.defaultCurrency,
        );
      } else {
        await HiveService.saveUserModel(
          UserModel(
            name: trimmedName,
            imagePath: state.imagePath,
            defaultCurrency: state.defaultCurrency,
            isFirstTime: false,
          ),
        );
      }
      await HiveService.setNotFirstTime();

      final updatedUser = HiveService.getUserModel();
      emit(
        state.copyWith(
          user: updatedUser,
          isSaving: false,
          isSaved: true,
        ),
      );
      return true;
    } catch (_) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: 'Failed to save profile. Please try again.',
        ),
      );
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
