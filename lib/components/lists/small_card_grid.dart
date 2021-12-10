import 'package:flutter/material.dart';
import 'package:rabble/components/cards/small_card.dart';

class SmallCardGrid extends StatelessWidget {
  const SmallCardGrid({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List list;

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
      itemCount: list.length,
      itemBuilder: (BuildContext ctx, index) {
        return SmallCard(
            title: list[index]['title'],
            subtitle: list[index]['subtitle'],
            playlistNavigation: list[index]['playlistNavigation'],
            imageUrl: list[index]['imageUrl']);
      },
    );
  }
}
