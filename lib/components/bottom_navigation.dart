import 'package:flutter/material.dart';

import '../constants.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {Key? key, required this.selectedIndex, required this.itemTapped})
      : super(key: key);

  final int selectedIndex;
  final Function itemTapped;

  void onItemTap(int index) {
    itemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: cNavbarGradient,
      ),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined),
              label: 'Library',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          unselectedItemColor: cIconSecondaryColor,
          selectedItemColor: cIconPrimaryColor,
          selectedFontSize: 12.0,
          elevation: 0,
          onTap: onItemTap,
        ),
      ),
    );
  }
}
