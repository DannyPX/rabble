import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rabble/services/state_controller/state_controller.dart';

import '../../constants.dart';

class SecondTitle extends StatelessWidget {
  SecondTitle({
    Key? key,
    required this.title,
    required this.hasNavigation,
    this.buttonTitle = "",
    this.navigateNavbar = false,
    this.navbarIndex = 0,
    this.screenToNavigateTo,
    this.showNavbar = false,
  }) : super(key: key);

  final _stateController = Get.find<GetController>();
  final String title;
  final bool hasNavigation;
  final String buttonTitle;
  final bool navigateNavbar;
  final int navbarIndex;
  final Widget? screenToNavigateTo;
  final bool showNavbar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hasNavigation
          ? const EdgeInsets.only(bottom: 8.0, top: 0.0)
          : const EdgeInsets.only(bottom: 11.0, top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: fTitle2Style),
          if (hasNavigation)
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(buttonTitle, style: fSmallTextButtonStyle),
              onPressed: () {
                if (!navigateNavbar) {
                  pushNewScreen(
                    context,
                    screen: screenToNavigateTo!,
                    withNavBar: showNavbar,
                  );
                } else {
                  _stateController.controller.jumpToTab(navbarIndex);
                }
              },
            ),
        ],
      ),
    );
  }
}
