import 'package:chat_app/chat_app.dart';
import 'package:chat_app/core/helper/extensions.dart';
import 'package:chat_app/core/helper/shared_preferences.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import for formatting date and time

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_theme.dart';
import 'custom_card_widget.dart';

class MyRoomsView extends StatefulWidget {
  const MyRoomsView({super.key});

  @override
  _MyRoomsViewState createState() => _MyRoomsViewState();
}

class _MyRoomsViewState extends State<MyRoomsView> {
  String? savedTitle;
  String? savedType;
  DateTime? savedTime;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    // Retrieve saved data from SharedPreferences
    savedTitle = await SharedPreferencesHelper.getData(key: "groupTitle");
    savedType = await SharedPreferencesHelper.getData(key: "groupType");
    savedTime = await SharedPreferencesHelper.getData(key: "groupCreatedTime");

    // Trigger UI rebuild after loading saved data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String currentTime = DateFormat('h:mm a').format(
        DateTime.now()); // Format time to 12-hour format with AM/PM

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeGroupLoading) {
          return CustomScrollView(
            slivers: [
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.groups.length,
                itemBuilder: (context, index) {
                  bool isMovie =
                  state.groups[index].groupType.contains("Movies");
                  bool isSport =
                  state.groups[index].groupType.contains("Sports");

                  // Save the group details when building the widget
                  SharedPreferencesHelper.setData(
                      key: "groupTitle", value: state.groups[index].title);
                  SharedPreferencesHelper.setData(
                      key: "groupType", value: state.groups[index].groupType);
                  SharedPreferencesHelper.setData(
                      key: "groupCreatedTime",
                      value: state.groups[index].currentTime);

                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.chatRoom);
                    },
                    child: CustomCardWidget(
                      title: state.groups[index].title,
                      description: state.groups[index].description,
                      currentTime: state.groups[index].currentTime,
                      imagePath: isMovie
                          ? "assets/images/movies.png"
                          : isSport
                          ? "assets/images/sports.png"
                          : "assets/images/music.png",
                    ),
                  );
                },
              ),
              // Display the saved group details if they exist
              if (savedTitle != null && savedType != null && savedTime != null)
                SliverToBoxAdapter(
                  child: CustomCardWidget(
                    title: savedTitle!,
                    description: "Persisted Description",
                    currentTime: savedTime!,
                    imagePath: savedType!.contains("Movies")
                        ? "assets/images/movies.png"
                        : savedType!.contains("Sports")
                        ? "assets/images/sports.png"
                        : "assets/images/general_chat.png",
                  ),
                ),
            ],
          );
        } else {
          return const Center(
            child: Text('No groups found.'),
          );
        }
      },
    );
  }
}
