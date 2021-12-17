import 'package:flutter/material.dart';
import 'package:rabble/components/lists/small_card_grid.dart';
import 'package:rabble/components/lists/song_row_list.dart';
import 'package:rabble/components/search/search_box.dart';
import 'package:rabble/components/titles/page_title.dart';
import 'package:rabble/components/titles/second_title.dart';
import 'package:rabble/layouts/main.dart';
import 'package:rabble/views/library.dart';
import 'package:rabble/views/playlist.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Map> playlists = List.generate(
      4,
      (index) => {
            "title": "title $index",
            "subtitle": "",
            "playlistNavigation": PlaylistPage(
                title: "title $index", imageUrl: "assets/images/stromae.jpg"),
            "imageUrl": "assets/images/stromae.jpg"
          }).toList();

  final List<Map> songs = List.generate(
      5,
      (index) => {
            "title": "title $index",
            "subtitle": "Stromae",
            "imageUrl": "assets/images/onboarding.jpg",
            "views": 123,
            "time": Duration(minutes: 3, seconds: 12),
          }).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(welcomeMessage: true, title: "Rabble"),
        const SizedBox(height: 16.0),
        const SearchBox(),
        const SizedBox(height: 16.0),
        SecondTitle(
          title: "Your playlists",
          hasNavigation: true,
          buttonTitle: "View more",
          navigateNavbar: true,
          navbarIndex: 2,
        ),
        SmallCardGrid(list: playlists),
        const SizedBox(height: 16.0),
        SecondTitle(
          title: "Recently listened",
          hasNavigation: false,
        ),
        SongRowList(list: songs, live: false),
      ],
    );
  }
}
