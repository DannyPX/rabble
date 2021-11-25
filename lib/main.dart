import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rabble/views/onboarding.dart';

void main() {
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
