import 'package:chat_app/core/helper/extensions.dart';
import 'package:chat_app/core/helper/shared_preferences.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/features/home/logic/home_cubit.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import for formatting date and time

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
                  // Get the groupType value and ensure it's case-insensitive
                  String groupType = state.groups[index].groupType.trim().toLowerCase();

                  // Correct comparison to check group type
                  bool isMovie = groupType == "movies";
                  bool isSport = groupType == "sport";
                  bool isMusic = groupType == "music";

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
                      // Display the correct image based on room type
                      imagePath: isMovie
                          ? "assets/images/movies.png"
                          : isSport
                              ? "assets/images/sports.png"
                              : "assets/images/music.png", // Default if no match
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
                    // Use savedType to select the correct image
                    imagePath: savedType!.trim().toLowerCase() == "movies"
                        ? "assets/images/movies.png"
                        : savedType!.trim().toLowerCase() == "sport"
                            ? "assets/images/sports.png"
                            : "assets/images/music.png", // Default if no match
                  ),
                ),

            ],
          );
        } else {
          return Center(
            child: Text(S.of(context).no_room_found),
          );
        }
      },
    );
  }
}
