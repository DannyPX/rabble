import 'package:flutter/material.dart';
import 'package:rabble/constants.dart';

class LargeCard extends StatefulWidget {
  const LargeCard({
    Key? key,
    required this.title,
    required this.songAmount,
    required this.playlistNavigation,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final int songAmount;
  final StatefulWidget playlistNavigation;
  final String imageUrl;

  @override
  State<LargeCard> createState() => _LargeCardState();
}

class _LargeCardState extends State<LargeCard> {
  String get title => widget.title;
  int get songAmount => widget.songAmount;
  StatefulWidget get playlistNavigation => widget.playlistNavigation;
  String get imageUrl => widget.imageUrl;

  double get circleSize => 25;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => playlistNavigation,
              fullscreenDialog: true,
            ));
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
              child: Column(children: [
                Expanded(
                    flex: 5,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          title,
                          style: fCardTitleStyle,
                        ),
                        subtitle: Text(songAmount.toString() + ' Songs',
                            style: fCardUnderTitleStyle),
                      ),
                    )),
              ]),
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: cButtonTransparentBgColor,
                radius: circleSize,
                child: const Icon(
                  Icons.chevron_right,
                  color: cTextPrimaryColor,
                ),
              ),
            ),
            SizedBox(width: circleSize)
          ])),
    );
  }
}
