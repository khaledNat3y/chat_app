import 'package:chat_app/features/home/ui/widgets/browse_view.dart';
import 'package:chat_app/features/home/ui/widgets/custom_drawer.dart';
import 'package:chat_app/features/home/ui/widgets/custom_floating_action_button.dart';
import 'package:chat_app/features/home/ui/widgets/my_rooms_view.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/app_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.white,
        ),
        Positioned.fill(
          child: Image.asset(
            AppAssets.background,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            floatingActionButtonLocation: FloatingActionButtonLocation
                .endFloat,
            floatingActionButton: const CustomFloatingActionButton(),
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.white,
                  size: 34,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
              title: Text(
                'MindMate',
                style: AppTheme.font24WhiteBold,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: AppColors.white, size: 34),
                )
              ],
              bottom: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicatorColor: AppColors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                unselectedLabelColor: AppColors.lighterGrey,
                tabs: [
                  Tab(
                    child: Text(
                      S.of(context).my_rooms,
                      style: AppTheme.font20WhiteMedium,
                    ),
                  ),
                  Tab(
                    child: Text(
                      S.of(context).browse,
                      style: AppTheme.font20WhiteMedium,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
                  child: const MyRoomsView(),
                ),
                const BrowseView(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}