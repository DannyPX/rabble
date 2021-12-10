import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'audio_handler.dart';
import 'audio_enum.dart';

class RabbleAudioService {
  late AudioHandler _audioHandler;
  final GetController _stateController = Get.find<GetController>();

  RabbleAudioService() {
    init();
  }

  Future<void> init() async {
    _audioHandler = await AudioService.init(
      builder: () => RabbleAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.djinc.rabble.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );

    _listenToPlaybackState();
    _listenToMediaItem();
    _loadPlaylist();
    _listenToChangesInSong();
  }

  Future<void> play() async {
    await _audioHandler.play();
  }

  Future<void> pause() async {
    _audioHandler.pause();
  }

  Future<void> stop() async {
    _audioHandler.stop();
  }

  Future<void> seek(Duration position) async {
    _audioHandler.seek(position);
  }

  Future<void> previous() async {
    _audioHandler.skipToPrevious();
  }

  Future<void> next() async {
    _audioHandler.skipToNext();
  }

  Future<void> _loadPlaylist() async {
    var item1 = MediaItem(
        id: 'SoundHelix-Song-1.mp3',
        album: '-',
        title: 'Song 1',
        artist: 'Artist 1',
        artUri: Uri.parse('https://example.com/album.jpg'),
        extras: {
          'url': 'assets/audio/SoundHelix-Song-1.mp3',
          'imageUrl': 'assets/images/onboarding.jpg'
        });

    var item2 = MediaItem(
        id: 'SoundHelix-Song-2.mp3',
        album: '-',
        title: 'Song 2',
        artist: 'Artist 2',
        artUri: Uri.parse('https://example.com/album.jpg'),
        extras: {
          'url': 'assets/audio/SoundHelix-Song-2.mp3',
          'imageUrl': 'assets/images/onboarding.jpg'
        });

    var item3 = MediaItem(
        id: 'SoundHelix-Song-3.mp3',
        album: '-',
        title: 'Song 3',
        artist: 'Artist 3',
        artUri: Uri.parse('https://example.com/album.jpg'),
        extras: {
          'url': 'assets/audio/SoundHelix-Song-3.mp3',
          'imageUrl': 'assets/images/onboarding.jpg'
        });

    var list = [item1, item2, item3];

    _audioHandler.addQueueItems(list);
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        _stateController.isPlaying = ButtonState.loading;
      } else if (!isPlaying) {
        _stateController.isPlaying = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        _stateController.isPlaying = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToMediaItem() {
    _audioHandler.mediaItem.listen((item) {
      if (item == null) return;
      _stateController.currentMediaItem = item;
    });
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      _stateController.currentPlaylist = playlist;
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      if (mediaItem == null) return;
      _stateController.currentMediaItem = mediaItem;
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      _stateController.isFirst = true;
      _stateController.isLast = true;
    } else {
      _stateController.isFirst = playlist.first == mediaItem;
      _stateController.isLast = playlist.last == mediaItem;
    }
  }
}
