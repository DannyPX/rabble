class QueryVideo {
  final String title;
  final String id;
  final String author;
  final Duration duration;
  final String thumbnail;
  final int viewCount;

  const QueryVideo(this.title, this.id, this.author, this.duration,
      this.thumbnail, this.viewCount);
}
