class VideoMetadata {
  final String title;
  final String id;
  final String author;
  final Duration duration;
  final String imageUrl;

  VideoMetadata.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        id = json["id"],
        author = json["author"],
        duration = Duration(seconds: (int.parse(json["duration"]))),
        imageUrl = json["thumbnail"];
}
