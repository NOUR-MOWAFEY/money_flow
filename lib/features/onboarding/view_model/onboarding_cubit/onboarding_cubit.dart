import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_state.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({ImagePicker? imagePicker})
    : _picker = imagePicker ?? ImagePicker(),
      super(const OnboardingState());

  final ImagePicker _picker;

  void setPage(int index) {
    if (index >= 0 && index < state.totalPages) {
      emit(state.copyWith(currentPage: index, clearError: true));
    }
  }

  void nextPage() {
    if (state.currentPage < state.totalPages - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1, clearError: true));
    }
  }

  void skipToSetup() {
    emit(state.copyWith(currentPage: state.totalPages - 1, clearError: true));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name, clearError: true));
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
        emit(state.copyWith(imagePath: file.path, clearError: true));
      }
    } catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to select image. Please try again.',
        ),
      );
    }
  }

  void removeImage() {
    emit(state.copyWith(clearImage: true, clearError: true));
  }

  void updateCurrency(String currencyCode) {
    emit(state.copyWith(currencyCode: currencyCode, clearError: true));
  }

  Future<bool> completeOnboarding() async {
    final trimmedName = state.name.trim();
    if (trimmedName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter your name to get started'));
      return false;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      final user = UserModel(
        name: trimmedName,
        imagePath: state.imagePath,
        defaultCurrency: state.currencyCode,
        isFirstTime: false,
      );
      await HiveService.saveUserModel(user);
      await HiveService.setNotFirstTime();

      emit(state.copyWith(isSubmitting: false, isCompleted: true));
      return true;
    } catch (_) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Failed to finish setup. Please try again.',
        ),
      );
      return false;
    }
  }
}
