import 'package:flutter/material.dart';
import 'package:rabble/components/cards/small_card.dart';
import 'package:rabble/views/search.dart';

class PlaylistGrid extends StatelessWidget {
  PlaylistGrid({Key? key}) : super(key: key);

  final List<Map> playlists = List.generate(
      4,
      (index) => {
            "title": "title $index",
            "subtitle": "",
            "playlistNavigation": const SearchPage(),
            "imageUrl": "assets/images/onboarding.jpg"
          }).toList();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: playlists.length,
      itemBuilder: (BuildContext ctx, index) {
        return SmallCard(
            title: playlists[index]['title'],
            subtitle: playlists[index]['subtitle'],
            playlistNavigation: playlists[index]['playlistNavigation'],
            imageUrl: playlists[index]['imageUrl']);
      },
    );
  }
}
