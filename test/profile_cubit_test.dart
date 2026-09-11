import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:money_flow/features/profile/view_model/profile_cubit/profile_state.dart';
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
  late ProfileCubit cubit;

  setUpAll(() {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('profile_test_');
    Hive.init(tempDir.path);
    await Hive.openBox('user');

    fakePicker = FakeImagePicker();
    cubit = ProfileCubit(imagePicker: fakePicker);
  });

  tearDown(() async {
    await cubit.close();
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('ProfileState tests', () {
    test('hasChanges detects name and image differences', () {
      final user = UserModel(name: 'Alice', imagePath: '/path/to/img.png');
      const state = ProfileState(user: null, name: 'Alice');
      expect(state.hasChanges, true);

      final stateWithUser = ProfileState(
        user: user,
        name: 'Alice',
        imagePath: '/path/to/img.png',
      );
      expect(stateWithUser.hasChanges, false);

      final modifiedName = stateWithUser.copyWith(name: 'Bob');
      expect(modifiedName.hasChanges, true);

      final modifiedImage = stateWithUser.copyWith(imagePath: '/new/img.png');
      expect(modifiedImage.hasChanges, true);
    });
  });

  group('ProfileCubit tests', () {
    test('loadProfile loads existing user or falls back to default', () {
      cubit.loadProfile();
      expect(cubit.state.name, 'User');
      expect(cubit.state.defaultCurrency, 'EGP');

      // Now save a user and reload
      HiveService.saveUserModel(
        UserModel(name: 'Jane Doe', defaultCurrency: 'USD'),
      );
      cubit.loadProfile();
      expect(cubit.state.name, 'Jane Doe');
      expect(cubit.state.defaultCurrency, 'USD');
    });

    test('updateName updates name in state and clears error', () {
      cubit.updateName('New Name');
      expect(cubit.state.name, 'New Name');
      expect(cubit.state.errorMessage, null);
    });

    test('pickImage updates imagePath on selection', () async {
      fakePicker.pickedFile = XFile('/tmp/test_image.png');
      await cubit.pickImage(ImageSource.gallery);
      expect(cubit.state.imagePath, '/tmp/test_image.png');
    });

    test('removeImage clears imagePath', () async {
      fakePicker.pickedFile = XFile('/tmp/test.png');
      await cubit.pickImage(ImageSource.gallery);
      cubit.removeImage();
      expect(cubit.state.imagePath, null);
    });

    test('saveProfile fails with empty name', () async {
      cubit.updateName('   ');
      final result = await cubit.saveProfile();
      expect(result, false);
      expect(cubit.state.errorMessage, 'Please enter your name');
      expect(cubit.state.isSaved, false);
    });

    test('saveProfile succeeds and persists to Hive', () async {
      cubit.updateName('Nour M.');
      final result = await cubit.saveProfile();
      expect(result, true);
      expect(cubit.state.isSaved, true);

      final savedUser = HiveService.getUserModel();
      expect(savedUser?.name, 'Nour M.');
    });
  });
}
