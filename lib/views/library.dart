import 'package:flutter/material.dart';
import 'package:rabble/components/pagetitle.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTitle(welcomeMessage: false, title: "Library"),
      ],
    );
  }
}
