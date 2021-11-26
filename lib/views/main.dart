import 'package:flutter/material.dart';
import 'package:rabble/components/bottom_navigation.dart';
import 'package:rabble/components/player.dart';
import 'package:rabble/views/home.dart';
import 'package:rabble/views/library.dart';
import 'package:rabble/views/search.dart';
import '../constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  int _selectedIndex = 0;
  static List<Widget> pages = <Widget>[
    HomePage(),
    const SearchPage(),
    LibraryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: cBackgroundColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 83.0),
                  child: pages[_selectedIndex],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Player(
                      title: 'Stromae - Santé (Official Music Video)',
                      subtitle: 'Stromae',
                      imageUrl: 'assets/images/onboarding.jpg',
                      totalTime: Duration(minutes: 3),
                      currentTime: Duration(minutes: 2, seconds: 30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
            selectedIndex: _selectedIndex, itemTapped: _onItemTapped),
      ),
    );
  }
}
