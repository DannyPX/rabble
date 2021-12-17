import 'package:flutter/material.dart';
import 'package:rabble/components/cards/song_row.dart';
import 'package:rabble/models/query_video.dart';

class SongRowList extends StatelessWidget {
  const SongRowList({
    Key? key,
    required this.list,
    required this.live,
  }) : super(key: key);

  final List list;
  final bool live;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (ctx, index) {
        if (!live) {
          return SongRow(
            title: list[index]['title'],
            subtitle: list[index]['subtitle'],
            imageUrl: list[index]['imageUrl'],
            views: list[index]['views'],
            time: list[index]['time'],
            live: live,
          );
        } else {
          final QueryVideo video = list[index];
          return SongRow(
            title: video.title,
            subtitle: video.author,
            imageUrl: video.thumbnail,
            views: video.viewCount,
            time: video.duration,
            live: live,
            id: video.id,
          );
        }
      },
    );
  }
}
