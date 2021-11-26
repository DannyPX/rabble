import 'package:flutter/material.dart';
import 'package:rabble/constants.dart';

class SmallCard extends StatefulWidget {
  const SmallCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.playlistNavigation,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget playlistNavigation;
  final String imageUrl;

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
  String get title => widget.title;
  String get subtitle => widget.subtitle;
  Widget get playlistNavigation => widget.playlistNavigation;
  String get imageUrl => widget.imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => playlistNavigation),
        );
      },
      child: Container(
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imageUrl,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(children: [
            Expanded(
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Expanded(
                          flex: 5,
                          child: ListTile(
                            title: Text(
                              title,
                              style: fCardTitleStyle,
                            ),
                            subtitle:
                                Text(subtitle, style: fCardUnderTitleStyle),
                          )),
                      Expanded(
                          flex: 5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: cTextPrimaryColor,
                                ),
                                SizedBox(width: 8),
                              ]))
                    ])))
          ])),
    );
  }
}
