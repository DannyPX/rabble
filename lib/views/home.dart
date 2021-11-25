import 'package:flutter/material.dart';
import 'package:rabble/components/lists/playlist_grid.dart';
import 'package:rabble/components/titles/page_title.dart';
import 'package:rabble/components/search_input.dart';
import 'package:rabble/components/titles/second_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(welcomeMessage: true, title: "Rabble"),
        const SizedBox(height: 16.0),
        const SearchInput(),
        const SizedBox(height: 16.0),
        const SecondTitle(title: "Your playlists", buttonTitle: "View more"),
        PlaylistGrid(),
        const SizedBox(height: 16.0),
        const SecondTitle(title: "Recently listened", buttonTitle: ""),
      ],
    );
  }
}
