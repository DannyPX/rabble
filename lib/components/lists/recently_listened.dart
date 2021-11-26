import 'package:flutter/material.dart';
import 'package:rabble/components/cards/song_row.dart';

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
