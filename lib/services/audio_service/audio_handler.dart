import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class RabbleAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations

  late AudioPlayer player;
  final _playlist = ConcatenatingAudioSource(children: []);

  RabbleAudioHandler() {
    player = AudioPlayer();
    _loadEmptyPlaylist();
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();
  }

  // The most common callbacks:
  @override
  Future<void> play() async {
    print('Playing!');
    await player.play();
  }

  @override
  Future<void> pause() async {
    player.pause();
  }

  @override
  Future<void> stop() async {
    player.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    player.seek(position);
  }

  @override
  Future<void> skipToNext() => player.seekToNext();

  @override
  Future<void> skipToPrevious() => player.seekToPrevious();

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // manage Just Audio
    final audioSource = await Future.wait(
        mediaItems.map((i) async => await _createAudioSource(i)));
    await _playlist.addAll(audioSource.toList());
    // notify system
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  Future<void> _loadEmptyPlaylist() async {
    _playlist.clear();
    try {
      await player.setAudioSource(_playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<UriAudioSource> _createAudioSource(MediaItem mediaItem) async {
    return AudioSource.uri(
      Uri.file(mediaItem.extras!['url']),
      tag: mediaItem,
    );
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[player.processingState]!,
        playing: playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  void _listenForDurationChanges() {
    player.durationStream.listen((duration) {
      final index = player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  void _listenForCurrentSongIndexChanges() {
    player.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      mediaItem.add(playlist[index]);
    });
  }
}
