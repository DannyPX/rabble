import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rabble/constants.dart';

class LargeCard extends StatelessWidget {
  const LargeCard({
    Key? key,
    required this.title,
    required this.songAmount,
    required this.playlistNavigation,
    required this.imageUrl,
    required this.isAsset,
  }) : super(key: key);

  final String title;
  final int songAmount;
  final Widget playlistNavigation;
  final String imageUrl;
  final bool isAsset;
  final double circleSize = 20;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: playlistNavigation,
          withNavBar: true,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          height: 100.0,
          child: Stack(
            children: [
              Hero(
                tag: title + imageUrl + "library",
                child: isAsset
                    ? Image.asset(
                        imageUrl,
                        height: 100,
                        width: Get.width,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imageUrl),
                        fit: BoxFit.cover,
                        height: 100,
                        width: Get.width,
                      ),
              ),
              Hero(
                tag: title + "gradient" + "library",
                child: Container(
                  height: 150.0,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      radius: 2.0,
                      colors: [
                        Color(0x00131521),
                        Color(0xBB131521),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
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
                            ),
                          ),
                        ],
                      ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
