import 'package:flutter/material.dart';
import 'package:rabble/services/audio_service/audio_service.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/views/main.dart';
import 'package:rabble/views/onboarding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? onboardingSeen;
Future<void> main() async {
  Get.put<StateController>(StateController(), permanent: true);
  Get.put<RabbleAudioService>(RabbleAudioService(), permanent: true);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboardingSeen = prefs.getBool('onboardingSeen') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rabble',
      home: onboardingSeen! ? MainPage() : OnboardingPage(),
    );
  }
}
