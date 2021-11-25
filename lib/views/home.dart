import 'package:flutter/material.dart';
import 'package:rabble/components/pagetitle.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTitle(welcomeMessage: true, title: "Rabble"),
      ],
    );
  }
}
