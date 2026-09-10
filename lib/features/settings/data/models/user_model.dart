import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 10)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? imagePath;

  @HiveField(2)
  String defaultCurrency;

  @HiveField(3)
  bool isFirstTime;

  UserModel({
    required this.name,
    this.imagePath,
    this.defaultCurrency = 'EGP',
    this.isFirstTime = true,
  });

  UserModel copyWith({
    String? name,
    String? imagePath,
    String? defaultCurrency,
    bool? isFirstTime,
  }) {
    return UserModel(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
      'defaultCurrency': defaultCurrency,
      'isFirstTime': isFirstTime,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String?,
      defaultCurrency: (json['defaultCurrency'] as String?) ?? 'EGP',
      isFirstTime: (json['isFirstTime'] as bool?) ?? true,
    );
  }
}
