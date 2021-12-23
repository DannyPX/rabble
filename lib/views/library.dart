import 'package:flutter/material.dart';
import 'package:rabble/components/lists/large_card_list.dart';
import 'package:rabble/components/lists/list_type_enum.dart';
import 'package:rabble/components/titles/page_title.dart';
import 'package:rabble/components/titles/second_title.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/views/playlist.dart';
import 'package:get/get.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);

  final GetController _stateController = Get.find<GetController>();

  final List<Map> playlists = List.generate(
      5,
      (index) => {
            "title": "title $index",
            "songAmount": 123,
            "playlistNavigation": PlaylistPage(
              title: "title $index",
              imageUrl: "assets/images/stromae.jpg",
              songlistMap: [],
              isLiveData: ListType.asset,
            ),
            "imageUrl": "assets/images/stromae.jpg",
          }).toList();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mapData =
        _stateController.songStorageData['downloaded'];
    List<dynamic> listData = mapData['songs'];

    List<Map> libraryList = List.from([
      {
        'title': 'Downloaded Songs',
        'songAmount': listData.length,
        'playlistNavigation': PlaylistPage(
          title: 'Downloaded Songs',
          imageUrl: 'assets/images/onboarding.jpg',
          songlistMap: listData,
          isLiveData: ListType.localStorage,
        ),
        'imageUrl': 'assets/images/onboarding.jpg',
      }
    ]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(welcomeMessage: false, title: "Library"),
        const SizedBox(height: 16.0),
        LargeCardList(
          list: libraryList,
          isAsset: true,
        ),
        const SizedBox(height: 16.0),
        SecondTitle(
          title: "Playlists",
          hasNavigation: true,
          buttonTitle: "Create playlist",
        ),
        LargeCardList(
          list: playlists,
          isAsset: true,
        ),
      ],
    );
  }
}
