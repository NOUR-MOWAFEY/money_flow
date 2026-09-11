import 'package:flutter/material.dart';

@immutable
class OnboardingState {
  const OnboardingState({
    this.currentPage = 0,
    this.totalPages = 4,
    this.name = '',
    this.imagePath,
    this.currencyCode = 'EGP',
    this.isSubmitting = false,
    this.errorMessage,
    this.isCompleted = false,
  });

  final int currentPage;
  final int totalPages;
  final String name;
  final String? imagePath;
  final String currencyCode;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isCompleted;

  bool get isLastPage => currentPage == totalPages - 1;
  bool get isSetupPage => isLastPage;

  OnboardingState copyWith({
    int? currentPage,
    int? totalPages,
    String? name,
    String? imagePath,
    bool clearImage = false,
    String? currencyCode,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      name: name ?? this.name,
      imagePath: clearImage ? null : (imagePath ?? this.imagePath),
      currencyCode: currencyCode ?? this.currencyCode,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
