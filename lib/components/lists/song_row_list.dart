import 'package:flutter/material.dart';
import 'package:rabble/components/cards/song_row.dart';
import 'package:rabble/components/lists/list_type_enum.dart';
import 'package:rabble/models/query_video.dart';

class SongRowList extends StatelessWidget {
  const SongRowList({
    Key? key,
    required this.list,
    required this.isLiveData,
  }) : super(key: key);

  final List list;
  final ListType isLiveData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (ctx, index) {
        switch (isLiveData) {
          case ListType.asset:
            return SongRow(
              title: list[index]['title'],
              subtitle: list[index]['subtitle'],
              imageUrl: list[index]['imageUrl'],
              time: list[index]['time'],
              isLiveData: isLiveData,
            );
          case ListType.internet:
            final QueryVideo video = list[index];
            return SongRow(
              title: video.title,
              subtitle: video.author,
              imageUrl: video.thumbnail,
              time: video.duration,
              isLiveData: isLiveData,
              id: video.id,
            );
          case ListType.localStorage:
            Map<String, dynamic> song = list[index];
            Map<String, String> extra = song['extras'];
            String imageUrl = extra['imageUrl'] ?? "?";
            return SongRow(
              title: song['title'],
              subtitle: song['artist'],
              imageUrl: imageUrl,
              time: song['duration'],
              isLiveData: isLiveData,
            );
        }
      },
    );
  }
}
