import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class RabbleAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations

  late final player;

  RabbleAudioHandler() {
    player = AudioPlayer();
  }

  // The most common callbacks:
  @override
  Future<void> play() async {
    print('Playing!');
    var duration =
        await player.setFilePath('assets/audio/Hinkik_Skystrike.mp3');
    player.play();
  }

  @override
  Future<void> pause() async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> seek(Duration position) async {}
}
