import 'package:chat_app/core/helper/extensions.dart';
import 'package:chat_app/features/home/data/models/drawer_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/helper/shared_preferences.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import 'custom_drawer_header.dart';
import 'custom_drawer_items_list_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomDrawerHeader(),

          // Build drawer items list view
          CustomDrawerItemsListView(
            drawerItems: _getDrawerItems(context),
          ),
        ],
      ),
    );
  }

  List<DrawerItemModel> _getDrawerItems(BuildContext context) {
    return [
      DrawerItemModel(
        title: AppLocalizations.of(context)!.settings,
        icon: FontAwesomeIcons.gear,
        color: AppColors.blue,
        onTap: () {
          context.pushNamed(Routes.settings);
        },
      ),
      DrawerItemModel(
        title: AppLocalizations.of(context)!.log_out,
        icon: FontAwesomeIcons.arrowRightFromBracket,
        color: AppColors.red,
        onTap: () {
          // Call logout function on tap
          _handleLogout(context);
        },
      ),
    ];
  }


  Future<void> _handleLogout(BuildContext context) async {
    try {
      await SharedPreferencesHelper.clearAllData();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed(Routes.login);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context)!.error_sign_out}: $e'),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }
}
