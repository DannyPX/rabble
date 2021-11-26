import 'package:flutter/material.dart';
import 'package:rabble/components/lists/small_card_grid.dart';
import 'package:rabble/components/lists/song_row_list.dart';
import 'package:rabble/components/titles/page_title.dart';
import 'package:rabble/components/search_input.dart';
import 'package:rabble/components/titles/second_title.dart';
import 'library.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Map> playlists = List.generate(
      4,
      (index) => {
            "title": "title $index",
            "subtitle": "",
            "playlistNavigation": LibraryPage(),
            "imageUrl": "assets/images/onboarding.jpg"
          }).toList();

  final List<Map> songs = List.generate(
      5,
      (index) => {
            "title": "title $index",
            "subtitle": "Stromae",
            "imageUrl": "assets/images/onboarding.jpg",
            "views": 123,
            "time": 3.12,
          }).toList();

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
        SmallCardGrid(list: playlists),
        const SizedBox(height: 16.0),
        const SecondTitle(title: "Recently listened", buttonTitle: ""),
        SongRowList(list: songs),
      ],
    );
  }
}
