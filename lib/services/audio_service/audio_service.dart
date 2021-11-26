import 'package:audio_service/audio_service.dart';
import 'audio_handler.dart';

class RabbleAudioService {
  late AudioHandler _audioHandler;

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
  }

  Future<void> play() async {
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
}
