import 'package:chat_app/core/helper/spacing.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    String englishValue = "en";
    String arabicValue = "ar";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Settings"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          verticalSpace(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu(

                dropdownMenuEntries: [
                DropdownMenuEntry(value: englishValue, label: 'English',),
                DropdownMenuEntry(value: arabicValue, label: 'اللغة العربية',),
              ],
              width: MediaQuery.sizeOf(context).width * 0.8,
              label: Text("Language"),),
            ],
          ),

        ],
      ),
    );
  }
}
