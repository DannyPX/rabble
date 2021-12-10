import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rabble/components/player.dart';
import 'package:rabble/layouts/main.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/views/home.dart';
import 'package:rabble/views/library.dart';
import 'package:rabble/views/search.dart';
import '../constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final GetController _stateController = Get.find<GetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PersistentTabView(
            context,
            controller: _stateController.controller,
            screens: _pages(),
            items: _navBarItems(),
            navBarHeight: 55.0,
            confineInSafeArea: true,
            backgroundColor: Colors.transparent,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: false,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            navBarStyle: NavBarStyle.style8,
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.easeInOutCirc,
              duration: Duration(milliseconds: 350),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 60.0),
                  child: Player(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _pages() {
    return [
      MainLayout(page: HomePage()),
      const MainLayout(page: SearchPage()),
      MainLayout(page: LibraryPage())
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: cIconPrimaryColor,
        inactiveColorPrimary: cIconTertiaryColor,
        opacity: 0.15,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: cIconPrimaryColor,
        inactiveColorPrimary: cIconTertiaryColor,
        opacity: 0.15,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.my_library_books_outlined),
        title: ("Library"),
        activeColorPrimary: cIconPrimaryColor,
        inactiveColorPrimary: cIconTertiaryColor,
        opacity: 0.15,
      )
    ];
  }
}
