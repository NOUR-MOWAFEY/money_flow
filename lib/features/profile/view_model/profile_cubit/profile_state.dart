import 'package:flutter/material.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';

@immutable
class ProfileState {
  const ProfileState({
    this.user,
    this.name = '',
    this.imagePath,
    this.defaultCurrency = 'EGP',
    this.isLoading = false,
    this.isSaving = false,
    this.isSaved = false,
    this.errorMessage,
  });

  final UserModel? user;
  final String name;
  final String? imagePath;
  final String defaultCurrency;
  final bool isLoading;
  final bool isSaving;
  final bool isSaved;
  final String? errorMessage;

  bool get hasChanges {
    final originalName = user?.name ?? '';
    final originalImage = user?.imagePath;
    return name.trim() != originalName.trim() || imagePath != originalImage;
  }

  ProfileState copyWith({
    UserModel? user,
    String? name,
    String? imagePath,
    bool clearImage = false,
    String? defaultCurrency,
    bool? isLoading,
    bool? isSaving,
    bool? isSaved,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileState(
      user: user ?? this.user,
      name: name ?? this.name,
      imagePath: clearImage ? null : (imagePath ?? this.imagePath),
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
