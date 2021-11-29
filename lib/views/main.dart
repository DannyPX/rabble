import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rabble/layouts/main.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/views/home.dart';
import 'package:rabble/views/library.dart';
import 'package:rabble/views/search.dart';
import '../constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  StateController _stateController = Get.find<StateController>();

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _stateController.controller,
      screens: _pages(),
      items: _navBarItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.transparent, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.transparent,
      ),
      navBarStyle:
          NavBarStyle.style2, // Choose the nav bar style with this property.
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
        inactiveColorPrimary: cIconSecondaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: cIconPrimaryColor,
        inactiveColorPrimary: cIconSecondaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.my_library_books_outlined),
        title: ("Library"),
        activeColorPrimary: cIconPrimaryColor,
        inactiveColorPrimary: cIconSecondaryColor,
      )
    ];
  }
}
