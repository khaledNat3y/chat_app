import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_theme.dart';
import '../../data/models/group_chat_model.dart';
import '../../logic/home_cubit.dart';

class GroupChatForm extends StatefulWidget {
  const GroupChatForm({super.key});

  @override
  GroupChatFormState createState() => GroupChatFormState();
}

class GroupChatFormState extends State<GroupChatForm> {
  final formKey = GlobalKey<FormState>();
  String? groupName;
  String? groupType;
  String? description;
  String? groupImage;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    List<String> groupTypes = [
      localizations.movies,
      localizations.sport,
      localizations.music];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.create_chat_room,
            style: AppTheme.font20BlackMedium,
          ),
          verticalSpace(10),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.4,
            height: MediaQuery.sizeOf(context).width * 0.2,
            child: Image.asset("assets/images/chat_app_icon.png",),
          ),
          verticalSpace(20),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Group Name Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.room_name,
                      labelStyle: AppTheme.font14GreyRegular,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                    ),
                    onSaved: (value) => groupName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_room_name;
                      }
                      return null;
                    },
                  ),
                  verticalSpace(20),
                  // Group Type Dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.room_type,
                      labelStyle: AppTheme.font14GreyRegular,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey)),
                    ),
                    items: groupTypes.map((String type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        groupType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_room_type;
                      }
                      return null;
                    },
                  ),
                  verticalSpace(20),
                  // Group Description Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.room_description,
                      labelStyle: AppTheme.font14GreyRegular,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey)),
                    ),
                    maxLines: 3,
                    onSaved: (value) => description = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_room_description;
                      }
                      return null;
                    },
                  ),
                  verticalSpace(30),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: MediaQuery.sizeOf(context).width * 0.13,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        WidgetStateProperty.all<Color>(AppColors.blue),
                        foregroundColor:
                        WidgetStateProperty.all<Color>(AppColors.white),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<HomeCubit>().createGroupChat(
                              GroupChatModel(
                                title: groupName!,
                                groupType: groupType!,
                                description: description!,
                                currentTime: DateTime.now(),));
                          Navigator.pop(
                              context); // Close the modal after creating the group
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.create_room),
                    ),
                  ),
                  verticalSpace(20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}