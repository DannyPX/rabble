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
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    LibraryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      // MADE THIS A STACK FOR CURRENTLY PLAYING CARD ADDED LATER
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
          ),
          Column(
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
        ],
      ),
      bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex, itemTapped: _onItemTapped),
    );
  }
}
