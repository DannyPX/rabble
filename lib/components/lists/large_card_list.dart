import 'package:flutter/material.dart';
import 'package:rabble/components/cards/large_card.dart';

class LargeCardList extends StatelessWidget {
  const LargeCardList({
    Key? key,
    required this.list,
    required this.isAsset,
  }) : super(key: key);

  final List list;
  final bool isAsset;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16.0);
      },
      shrinkWrap: true,
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (ctx, index) {
        return LargeCard(
          title: list[index]['title'],
          songAmount: list[index]['songAmount'],
          playlistNavigation: list[index]['playlistNavigation'],
          imageUrl: list[index]['imageUrl'],
          isAsset: isAsset,
        );
      },
    );
  }
}
