import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rabble/components/lists/list_type_enum.dart';
import 'package:rabble/constants.dart';
import 'package:rabble/models/query_video.dart';
import 'package:rabble/services/audio_service/audio_service.dart';
import 'package:rabble/services/download/download_service.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/shared.dart';
import 'package:rabble/views/song.dart';

class SongRow extends StatefulWidget {
  SongRow({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.time,
    required this.isLiveData,
    this.id,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Duration time;
  final String imageUrl;
  final ListType isLiveData;
  String? id;

  @override
  State<SongRow> createState() => _SongRowState();
}

class _SongRowState extends State<SongRow> {
  final _stateController = Get.find<GetController>();

  String get title => widget.title;

  String get subtitle => widget.subtitle;

  String get imageUrl => widget.imageUrl;

  Duration get time => widget.time;

  ListType get isLiveData => widget.isLiveData;

  String? get id => widget.id;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: cTextTertiaryColor),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // TODO update state with song details
          if (isLiveData == ListType.localStorage) {
            pushNewScreen(
              context,
              screen: SongPage(),
              withNavBar: false,
            );
          }
        },
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: _formatImage(imageUrl, isLiveData),
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
                              Icons.access_time,
                              color: cTextTertiaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              formatDuration(time),
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
            Center(
              child: GestureDetector(
                onTap: () {
                  if (isLiveData == ListType.internet && !loading) {
                    download(
                      QueryVideo(
                        title,
                        id!,
                        subtitle,
                        time,
                        imageUrl,
                      ),
                      context,
                    );

                    setState(() {
                      loading = true;
                    });
                  }
                  print("Add to playlist");
                },
                child: Icon(
                  isLiveData == ListType.internet
                      ? (loading
                          ? Icons.circle_outlined
                          : Icons.download_rounded)
                      : Icons.playlist_add,
                  color: cTextTertiaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image _formatImage(String image, ListType live) {
    switch (live) {
      case ListType.internet:
        return Image.network(
          image,
          fit: BoxFit.cover,
        );
      case ListType.asset:
        return Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
        );
      case ListType.localStorage:
        return Image.file(
          File(image),
          fit: BoxFit.cover,
        );
    }
  }

  Future<void> download(QueryVideo video, BuildContext context) async {
    final _audioHandler = Get.find<RabbleAudioService>();
    await downloadAudioStream(video).then((value) {
      if (value) {
        if (_stateController.currentPlaylistName == 'downloaded') {
          _audioHandler.addToQueue(video.id, 'downloaded');
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(getSnackBar('${video.title} downloaded'));
        setState(() {
          loading = false;
        });
      }
    });
  }
}
