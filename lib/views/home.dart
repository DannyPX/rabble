import 'package:flutter/material.dart';
import 'package:rabble/components/pagetitle.dart';
import 'package:rabble/components/search_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(welcomeMessage: true, title: "Rabble"),
        const SizedBox(height: 17.0),
        SearchInput(),
      ],
    );
  }
}
