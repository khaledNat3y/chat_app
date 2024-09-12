import 'package:chat_app/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import 'group_chat_form.dart';

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
