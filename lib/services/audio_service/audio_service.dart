import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'audio_handler.dart';
import 'audio_enum.dart';

class RabbleAudioService {
  late AudioHandler _audioHandler;
  final StateController _stateController = Get.find<StateController>();

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
  }

  Future<void> play() async {
    var item = MediaItem(
      id: 'https://example.com/audio.mp3',
      album: 'Album name',
      title: 'Track title',
      artist: 'Artist name',
      duration: const Duration(minutes: 3),
      artUri: Uri.parse('https://example.com/album.jpg'),
    );

    _audioHandler.addQueueItem(item);

    _audioHandler.play();
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

  Future<void> playMediaItem() async {}

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
}
