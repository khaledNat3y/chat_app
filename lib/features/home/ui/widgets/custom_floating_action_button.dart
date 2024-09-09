import 'package:chat_app/chat_app.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:chat_app/core/theming/app_theme.dart';
import 'package:chat_app/features/home/data/models/group_chat_model.dart';
import 'package:chat_app/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.blue,
      shape: const CircleBorder(),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return BlocProvider.value(
              value: context.read<HomeCubit>(), // Pass the HomeCubit instance
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: const GroupChatForm(),
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }
}

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

  final List<String> groupTypes = ['Movies', 'Sports', 'General Chat'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Makes the sheet content dynamic
        children: [
          Text(
            'Create Group Chat',
            style: AppTheme.font20BlackMedium,
          ),
          verticalSpace(10),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.4,
            height: MediaQuery.sizeOf(context).width * 0.2,
            child: Image.asset("assets/images/group_image.png"),
          ),
          verticalSpace(20),
          Form(
            key: formKey,
            child: Column(
              children: [
                // Group Name Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Group Name',
                    labelStyle: AppTheme.font14GreyRegular,
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                  ),
                  onSaved: (value) => groupName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                // Group Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Group Type',
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
                      return 'Please select a group type';
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                // Group Description Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Room Description',
                    labelStyle: AppTheme.font14GreyRegular,
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey)),
                  ),
                  maxLines: 3,
                  onSaved: (value) => description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
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
                    child: const Text('Create Group'),
                  ),
                ),
                verticalSpace(20)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
