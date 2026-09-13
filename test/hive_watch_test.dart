import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';

void main() {
  late Directory tempDir;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_watch_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('watchUserModel emits when user model is updated', () async {
    await HiveService.saveUserModel(
      UserModel(name: 'User', defaultCurrency: 'EGP'),
    );

    final events = <BoxEvent>[];
    final sub = HiveService.watchUserModel().listen(events.add);

    await HiveService.updateUserModel(defaultCurrency: 'USD');
    await Future.delayed(const Duration(milliseconds: 50));

    expect(events.length, 1);
    expect((events.first.value as UserModel).defaultCurrency, 'USD');

    await sub.cancel();
  });
}
