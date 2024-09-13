import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io'; // For handling file
import '../../../../core/helper/shared_preferences.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/app_theme.dart';

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({super.key});

  @override
  CustomDrawerHeaderState createState() => CustomDrawerHeaderState();
}

class CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  String? firstName = SharedPreferencesHelper.getData(key: "FirstName");
  String firstNameFromGoogleAccount = SharedPreferencesHelper.getData(key: "FirstNameFromGoogleAccount") ?? null;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage(); // Load the saved image on widget initialization
  }

  // Load the saved image path from SharedPreferences
  Future<void> _loadProfileImage() async {
    String? imagePath = SharedPreferencesHelper.getData(key: "profileImagePath");
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, pick the image
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });

        // Save the selected image path to SharedPreferences
        SharedPreferencesHelper.setData(key: "profileImagePath", value: pickedFile.path);

        print('Image selected: ${pickedFile.path}');
      }
    } else {
      // Handle the case when permission is not granted
      print('Permission not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Chat App",
            style: AppTheme.font24BlueBold,
          ),
          Expanded(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40.r,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                )
                    : null,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
                text: "Welcome ",
                style: AppTheme.font20BlackMedium,
                children: [
                  TextSpan(text: firstName ?? firstNameFromGoogleAccount, style: AppTheme.font20BlueMedium),
                ]),
          ),
        ],
      ),
    );
  }
}
