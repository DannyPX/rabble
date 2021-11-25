import 'package:flutter/material.dart';
import 'package:rabble/components/cards/song_row.dart';
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
        RecentlyListened(),
      ],
    );
  }
}

class RecentlyListened extends StatelessWidget {
  RecentlyListened({Key? key}) : super(key: key);

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
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (ctx, index) {
        return SongRow(
          title: songs[index]['title'],
          subtitle: songs[index]['subtitle'],
          imageUrl: songs[index]['imageUrl'],
          views: songs[index]['views'],
          time: songs[index]['time'],
        );
      },
    );
  }
}
