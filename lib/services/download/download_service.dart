import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rabble/models/query_video.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> downloadAudioStream(QueryVideo video) async {
  var yt = YoutubeExplode();
  var manifest = await yt.videos.streamsClient.getManifest(video.id);
  var streamInfo = manifest.audioOnly.withHighestBitrate();

  var stream = yt.videos.streamsClient.get(streamInfo);

  final directory = await getApplicationDocumentsDirectory();
  final Directory _appDocDirFolder =
      Directory('${directory.path}/downloaded/${video.id}/');

  if (await _appDocDirFolder.exists()) {
  } else {
    //if folder not exists create folder and then return its path
    await _appDocDirFolder.create(recursive: true);
  }

  await writeAudioToFile(directory.path, video.id, stream);
  await writeImageToFile(directory.path, video.id, video.thumbnail);
  await writeMetaDataToFile(directory.path, video.id, video);
  yt.close();
  return true;
}

Future<void> writeAudioToFile(
    String path, String id, Stream<List<int>> stream) async {
  var file = File("$path/downloaded/$id/audio.webm");
  var fileStream = file.openWrite();
  await stream.pipe(fileStream);

  await fileStream.flush();
  await fileStream.close();
}

Future<void> writeImageToFile(String path, String id, String imageUrl) async {
  var file = File("$path/downloaded/$id/thumbnail.jpg");
  var response = await http.get(Uri.parse(imageUrl));
  file.writeAsBytesSync(response.bodyBytes);
}

Future<void> writeMetaDataToFile(
    String path, String id, QueryVideo video) async {
  Map<String, dynamic> jsonMetadata = {
    'title': video.title,
    'id': video.id,
    'author': video.author,
    'duration': video.duration.inSeconds.toString(),
    'thumbnail': video.thumbnail,
    'viewCount': video.viewCount.toString(),
  };
  var file = File("$path/downloaded/$id/metadata.json");
  file.writeAsStringSync(json.encode(jsonMetadata));
}
