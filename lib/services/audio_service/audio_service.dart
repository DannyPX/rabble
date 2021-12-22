import 'dart:convert';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:rabble/models/video_metadata.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'audio_handler.dart';
import 'audio_enum.dart';
import 'package:path_provider/path_provider.dart';

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

    final directory = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder =
        Directory('${directory.path}/downloaded/');

    if (await _appDocDirFolder.exists()) {
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder.create(recursive: true);
    }

    _listenToPlaybackState();
    _listenToMediaItem();
    loadPlaylist('downloaded');
    _listenToChangesInSong();
    _listenToChangesInPlaylist();
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

  Future<void> loadPlaylist(String playlistName) async {
    _stateController.currentPlaylistName = playlistName;
    List<FileSystemEntity> _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String playlistDir = '$dir/$playlistName/';
    Directory myDir = Directory(playlistDir);
    _folders = await myDir.list(recursive: false, followLinks: false).toList();
    _audioHandler.addQueueItems(await _loadDirectoryPlaylist(_folders));
  }

  Future<List<MediaItem>> _loadDirectoryPlaylist(
      List<FileSystemEntity> folders) async {
    List<MediaItem> playlist = [];
    for (var element in folders) {
      if (element is Directory) {
        Directory currentDir = element;
        File currentFile = File(currentDir.path + '/metadata.json');
        final contents = await currentFile.readAsString();
        Map<String, dynamic> metadataMap = json.decode(contents);
        VideoMetadata metadata = VideoMetadata.fromJson(metadataMap);

        playlist.add(MediaItem(
            id: metadata.id,
            album: '-',
            title: metadata.title,
            artist: metadata.author,
            artUri: Uri.file(currentDir.path + '/thumbnail.jpg'),
            extras: {
              'url': currentDir.path + '/audio.webm',
              'imageUrl': currentDir.path + '/thumbnail.jpg'
            }));
      }
    }
    return playlist;
  }

  Future<void> addToQueue(String id, String playlist) async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String songDir = '$dir/$playlist/$id';
    _audioHandler
        .addQueueItems(List.of([await _loadDirectoryMediaItem(songDir)]));
  }

  Future<MediaItem> _loadDirectoryMediaItem(String songDir) async {
    File currentFile = File(songDir + '/metadata.json');
    final contents = await currentFile.readAsString();
    Map<String, dynamic> metadataMap = json.decode(contents);
    VideoMetadata metadata = VideoMetadata.fromJson(metadataMap);

    return MediaItem(
        id: metadata.id,
        album: '-',
        title: metadata.title,
        artist: metadata.author,
        artUri: Uri.file(songDir + '/thumbnail.jpg'),
        extras: {
          'url': songDir + '/audio.webm',
          'imageUrl': songDir + '/thumbnail.jpg'
        });
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
