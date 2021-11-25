import 'package:flutter/material.dart';
import 'package:rabble/constants.dart';

class SongRow extends StatefulWidget {
  const SongRow({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.views,
    required this.time,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final int views;
  final double time;
  final String imageUrl;

  @override
  State<SongRow> createState() => _SongRowState();
}

class _SongRowState extends State<SongRow> {
  String get title => widget.title;

  String get subtitle => widget.subtitle;

  String get imageUrl => widget.imageUrl;

  int get views => widget.views;

  double get time => widget.time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: cTextTertiaryColor),
        ),
      ),
      child: Row(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Expanded(
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //TODO Add play button
                  ],
                ),
                flex: 2,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      title: Text(
                        title,
                        style: fListTitleStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        subtitle,
                        style: fListUnderTitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      title: Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: cTextTertiaryColor,
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 35,
                            child: Text(
                              views.toString(),
                              style: fListUnderTitleStyle,
                              maxLines: 1,
                            ),
                          ),
                          const Icon(
                            Icons.access_time,
                            color: cTextTertiaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            time.toString(),
                            style: fListUnderTitleStyle,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Center(
            //TODO Add to playlist
            child: Icon(
              Icons.playlist_add,
              color: cTextTertiaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
