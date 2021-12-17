import 'package:flutter/material.dart';
import 'package:rabble/components/lists/large_card_list.dart';
import 'package:rabble/components/titles/page_title.dart';
import 'package:rabble/components/titles/second_title.dart';
import 'package:rabble/views/search.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);

  final List<Map> libaryList = List.generate(
      2,
      (index) => {
            "title": "title $index",
            "songAmount": 123,
            "playlistNavigation": const SearchPage(),
            "imageUrl": "assets/images/onboarding.jpg",
          }).toList();

  final List<Map> playlists = List.generate(
      5,
      (index) => {
            "title": "title $index",
            "songAmount": 123,
            "playlistNavigation": const SearchPage(),
            "imageUrl": "assets/images/onboarding.jpg",
          }).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(welcomeMessage: false, title: "Library"),
        const SizedBox(height: 16.0),
        LargeCardList(list: libaryList),
        const SizedBox(height: 16.0),
        SecondTitle(
          title: "Playlists",
          hasNavigation: true,
          buttonTitle: "Create playlist",
        ),
        LargeCardList(list: playlists),
      ],
    );
  }
}
