import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final ytProvider = Provider<YoutubeExplode>((ref) => YoutubeExplode(),
    name: 'YT Explode provider');
