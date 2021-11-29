import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rabble/services/audio_service/audio_service.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/views/onboarding.dart';
import 'package:get/get.dart';

Future<void> main() async {
  Get.put<StateController>(StateController(), permanent: true);
  Get.put<RabbleAudioService>(RabbleAudioService(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rabble',
      home: OnboardingPage(),
    );
  }
}
