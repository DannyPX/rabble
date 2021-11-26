import 'package:flutter/material.dart';
import 'package:rabble/components/cards/song_row.dart';

class SongRowList extends StatelessWidget {
  const SongRowList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (ctx, index) {
        return SongRow(
          title: list[index]['title'],
          subtitle: list[index]['subtitle'],
          imageUrl: list[index]['imageUrl'],
          views: list[index]['views'],
          time: list[index]['time'],
        );
      },
    );
  }
}
