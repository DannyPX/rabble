import 'package:flutter/material.dart';
import 'package:rabble/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);
  final StateController _stateController = Get.find<StateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: Center(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'assets/images/onboarding.jpg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .5,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .43,
                  ),
                  child: SvgPicture.asset(
                    'assets/logos/rabble.svg',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Music expresses that which cannot be put into words and that which cannot remain silent.",
                style: fTitle2Style,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                children: [
                  Text(
                    "Rabble does not require you to create an account, all music is stored on your device.",
                    style: fCaptionTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 17.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: cPrimaryGradiant,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          width: double.infinity,
                          child: Text(
                            "Let's get started",
                            textAlign: TextAlign.center,
                            style: fElevatedButtonStyle,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('onboardingSeen', true);
                        Get.off(MainPage());
                      },
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
