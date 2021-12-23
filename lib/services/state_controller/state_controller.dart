import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rabble/services/audio_service/audio_enum.dart';

class GetController extends GetxController {
  GetController();

  ButtonState isPlaying = ButtonState.paused;
  MediaItem currentMediaItem = MediaItem(
      id: '0', title: 'Track Test', artist: '', extras: {'imageUrl': ''});
  List<MediaItem> currentPlaylist = List.empty();
  String currentPlaylistName = '';
  Map<String, dynamic> songStorageData = {
    'downloaded': Map<String, dynamic>.from({
      'amountSongs': 0,
      'songs': List.empty(growable: true),
    }),
    'playlists': List<Map>.empty(growable: true),
  };
  bool isFirst = true;
  bool isLast = false;
  bool isLoop = false;
  bool isShuffle = false;

  PersistentTabController controller = PersistentTabController(initialIndex: 0);
}
