import 'package:flutter/material.dart';
import 'package:rabble/components/pagetitle.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTitle(welcomeMessage: true, title: "Search"),
      ],
    );
  }
}
