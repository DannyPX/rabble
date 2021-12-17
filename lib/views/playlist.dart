import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rabble/components/lists/song_row_list.dart';
import 'package:rabble/constants.dart';
import 'package:get/get.dart';

class PlaylistPage extends StatelessWidget {
  PlaylistPage({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String imageUrl;

  final List<Map> songs = List.generate(
      3,
      (index) => {
            "title": "title $index",
            "subtitle": "Stromae",
            "imageUrl": "assets/images/stromae.jpg",
            "views": 123,
            "time": Duration(minutes: 3, seconds: 12),
          }).toList();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBody: true,
        backgroundColor: cBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 150.0,
                    width: Get.width,
                    child: Hero(
                      tag: title + imageUrl,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Hero(
                    tag: title + "gradient",
                    child: Container(
                      height: 152.0,
                      decoration: const BoxDecoration(
                        gradient: cTopGradient,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 130.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Hero(
                            tag: title,
                            child: Text(title, style: fTitleStyle),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SongRowList(list: songs, live: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
