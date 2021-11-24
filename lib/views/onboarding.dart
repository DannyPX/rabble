import 'package:flutter/material.dart';
import 'package:rabble/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/images/onboarding.jpg',
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            SvgPicture.asset(
              'assets/logos/rabble.svg',
            ),
          ],
        ),
      ),
    );
  }
}
