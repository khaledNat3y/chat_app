import 'package:chat_app/core/theming/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import '../../../core/helper/shared_preferences.dart';
import 'logic/settings_cubit.dart';
@injectable
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSelected = true; // Tracks the selection (true = English, false = Arabic)

  @override
  void initState() {
    super.initState();
    _loadSelection();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('English'),
            selected: isSelected,
            trailing: isSelected ? const Icon(Icons.done) : null,
            selectedColor: AppColors.blue,
            onTap: () {
              _onLanguageSelected('en', true);
            },
          ),
          ListTile(
            title: const Text("اللغة العربية"),
            selected: !isSelected,
            selectedColor: AppColors.blue,
            trailing: !isSelected ? const Icon(Icons.done) : null,
            onTap: () {
              _onLanguageSelected('ar', false);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _loadSelection() async {
    // Load the saved language from SharedPreferences
    String? savedLanguageCode = await SharedPreferencesHelper.getData(key: 'language');
    if (savedLanguageCode != null) {
      setState(() {
        isSelected = savedLanguageCode == 'en';
      });
    }
  }

  void _onLanguageSelected(String languageCode, bool selected) {
    setState(() {
      isSelected = selected;
    });
    // Save the language in SharedPreferences
    SharedPreferencesHelper.setData(key: 'language', value: languageCode);
    context.read<SettingsCubit>().changeLocale(languageCode);
  }
}