import 'package:flutter/foundation.dart';

@immutable
abstract class CreateEnvironmentState {}

class CreateEnvironmentInitial extends CreateEnvironmentState {}

class CreateEnvironmentLoading extends CreateEnvironmentState {}

class CreateEnvironmentSuccess extends CreateEnvironmentState {
  CreateEnvironmentSuccess(this.environmentName, {this.isEditing = false});

  final String environmentName;
  final bool isEditing;
}

class CreateEnvironmentFailure extends CreateEnvironmentState {
  CreateEnvironmentFailure(this.errorMessage);

  final String errorMessage;
}
