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

    _checkDirectories();
    loadDirectoryToState();
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
    _audioHandler.addQueueItems(
        await _loadDirectoryPlaylist(await loadFolders(playlistName)));
  }

  Future<List<FileSystemEntity>> loadFolders(String folderName) async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String folderDir = '$dir/$folderName/';
    Directory myDir = Directory(folderDir);
    return await myDir.list(recursive: false, followLinks: false).toList();
  }

  Future<List<MediaItem>> _loadDirectoryPlaylist(
      List<FileSystemEntity> folders) async {
    List<MediaItem> playlist = [];
    for (var element in folders) {
      if (element is Directory) {
        Directory currentDir = element;
        VideoMetadata metadata = await _loadMetadata(currentDir);

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

  Future<void> _checkDirectories() async {
    final directory = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder =
        Directory('${directory.path}/downloaded/');

    if (await _appDocDirFolder.exists()) {
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder.create(recursive: true);
    }

    final Directory _appDocDirFolder2 =
        Directory('${directory.path}/playlists/');

    if (await _appDocDirFolder2.exists()) {
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder2.create(recursive: true);
    }
  }

  Future<void> loadDirectoryToState() async {
    _stateController.updateDownloadedStorageData(Map<String, dynamic>.from({
      'amountSongs': 0,
      'songs': List.empty(growable: true),
    }));

    List<FileSystemEntity> _folders = await loadFolders('downloaded');
    for (var element in _folders) {
      if (element is Directory) {
        Directory currentDir = element;
        VideoMetadata metadata = await _loadMetadata(currentDir);

        Map<String, dynamic> mapData =
            _stateController.songStorageData['downloaded'];
        List<dynamic> listData = mapData['songs'];

        listData.add({
          'id': metadata.id,
          'album': '-',
          'title': metadata.title,
          'artist': metadata.author,
          'artUri': Uri.file(currentDir.path + '/thumbnail.jpg'),
          'duration': metadata.duration,
          'extras': Map<String, String>.from({
            'url': currentDir.path + '/audio.webm',
            'imageUrl': currentDir.path + '/thumbnail.jpg'
          })
        });
        _stateController.updateDownloadedStorageData(mapData);
      }
    }
  }

  Future<VideoMetadata> _loadMetadata(Directory songDir) async {
    File currentFile = File(songDir.path + '/metadata.json');
    final contents = await currentFile.readAsString();
    Map<String, dynamic> metadataMap = json.decode(contents);
    return VideoMetadata.fromJson(metadataMap);
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
