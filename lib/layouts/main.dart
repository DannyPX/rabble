import 'package:flutter/material.dart';
import 'package:rabble/components/player.dart';
import '../constants.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    Key? key,
    required this.page,
  }) : super(key: key);

  final Widget page;

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
                  child: page,
                ),
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
                    child: Player(
                      title: 'Stromae - Santé (Official Music Video)',
                      subtitle: 'Stromae',
                      imageUrl: 'assets/images/onboarding.jpg',
                      totalTime: const Duration(minutes: 3),
                      currentTime: const Duration(minutes: 2, seconds: 30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
