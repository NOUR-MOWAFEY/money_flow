import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/views/home_view.dart';
import 'package:money_flow/widgets/custom_button.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = HiveService.userName;
    String imagePath = HiveService.userImage;
    if (imagePath.isNotEmpty) {
      _image = File(imagePath);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    String name = _nameController.text.trim();
    String imagePath = _image?.path ?? '';

    await HiveService.saveUser(name, imagePath);
    await HiveService.setNotFirstTime();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(flex: 1),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.secondaryColorWithHeightOpacity,
                radius: 60,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.person, size: 48)
                    : null,
              ),
            ),
            const SizedBox(height: 48),
            CustomTextFormFiled(
              isNormalTextField: true,
              controller: _nameController,
              showCursor: true,
              centerText: false,
              padding: const EdgeInsets.all(16),
              hintText: 'Name',
              showPrefixIcon: false,
            ),
            const Spacer(flex: 4),
            CustomButton(title: 'Save', height: 50, onTap: _saveProfile),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
