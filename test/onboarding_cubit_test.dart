import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';

class FakeImagePicker implements ImagePicker {
  XFile? pickedFile;

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    return pickedFile;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Directory tempDir;
  late FakeImagePicker fakePicker;
  late OnboardingCubit cubit;

  setUpAll(() {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('onboarding_test_');
    Hive.init(tempDir.path);
    await Hive.openBox('user');

    fakePicker = FakeImagePicker();
    cubit = OnboardingCubit(imagePicker: fakePicker);
  });

  tearDown(() async {
    await cubit.close();
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('OnboardingCubit Navigation', () {
    test('initial state has page 0 and totalPages 4', () {
      expect(cubit.state.currentPage, 0);
      expect(cubit.state.totalPages, 4);
      expect(cubit.state.name, '');
      expect(cubit.state.currencyCode, 'EGP');
      expect(cubit.state.isCompleted, false);
    });

    test('nextPage increments currentPage', () {
      cubit.nextPage();
      expect(cubit.state.currentPage, 1);
      cubit.nextPage();
      expect(cubit.state.currentPage, 2);
    });

    test('setPage updates page within bounds', () {
      cubit.setPage(3);
      expect(cubit.state.currentPage, 3);
      // Beyond totalPages should be ignored
      cubit.setPage(10);
      expect(cubit.state.currentPage, 3);
    });

    test('skipToSetup jumps to last page', () {
      cubit.skipToSetup();
      expect(cubit.state.currentPage, 3);
    });
  });

  group('OnboardingCubit Setup Fields', () {
    test('updateName updates name and clears error', () {
      cubit.updateName('Nour');
      expect(cubit.state.name, 'Nour');
      expect(cubit.state.errorMessage, isNull);
    });

    test('updateCurrency updates currencyCode', () {
      cubit.updateCurrency('USD');
      expect(cubit.state.currencyCode, 'USD');
    });

    test('pickImage updates imagePath on success', () async {
      fakePicker.pickedFile = XFile('/path/avatar.png');
      await cubit.pickImage(ImageSource.gallery);
      expect(cubit.state.imagePath, '/path/avatar.png');
    });

    test('removeImage clears imagePath', () {
      cubit.emit(cubit.state.copyWith(imagePath: '/path/avatar.png'));
      cubit.removeImage();
      expect(cubit.state.imagePath, isNull);
    });
  });

  group('Onboarding Completion', () {
    test('fails if name is empty with friendly error', () async {
      final success = await cubit.completeOnboarding();
      expect(success, false);
      expect(cubit.state.errorMessage, contains('enter your name'));
      expect(cubit.state.isCompleted, false);
    });

    test('succeeds with valid name, saves user to Hive, and marks isFirstTime false', () async {
      cubit.updateName('Nour Mowafey');
      cubit.updateCurrency('EUR');
      fakePicker.pickedFile = XFile('/path/to/pic.png');
      await cubit.pickImage(ImageSource.gallery);

      final success = await cubit.completeOnboarding();
      expect(success, true);
      expect(cubit.state.isCompleted, true);
      expect(cubit.state.errorMessage, isNull);

      // Verify Hive persistence
      final savedUser = HiveService.getUserModel();
      expect(savedUser, isNotNull);
      expect(savedUser!.name, 'Nour Mowafey');
      expect(savedUser.defaultCurrency, 'EUR');
      expect(savedUser.imagePath, '/path/to/pic.png');
      expect(savedUser.isFirstTime, false);
      expect(HiveService.isFirstTime, false);
    });
  });
}
