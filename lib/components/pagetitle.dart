import 'package:flutter/material.dart';

import '../constants.dart';

class PageTitle extends StatelessWidget {
  PageTitle({Key? key, required this.welcomeMessage, required this.title})
      : super(key: key);

  bool welcomeMessage;
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (welcomeMessage) Text("Welcome to", style: fUpperTitle),
        Text(title, style: fTitleStyle),
      ],
    );
  }
}
