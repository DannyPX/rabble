import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rabble/constants.dart';

class SmallCard extends StatelessWidget {
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
                tag: title + imageUrl,
                child: Image.asset(
                  imageUrl,
                  height: 100,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              Hero(
                tag: title + "gradient",
                child: Container(
                  height: 150.0,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      radius: .97,
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
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Hero(
                                  tag: title,
                                  child: Text(
                                    title,
                                    style: fCardTitleStyle,
                                  ),
                                ),
                                subtitle:
                                    Text(subtitle, style: fCardUnderTitleStyle),
                              ),
                            ),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
