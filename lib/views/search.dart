import 'package:flutter/material.dart';
import 'package:rabble/components/search/input_field.dart';
import 'package:rabble/components/titles/page_title.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(welcomeMessage: false, title: "Search"),
        const SizedBox(height: 17.0),
        InputField(),
      ],
    );
  }
}
