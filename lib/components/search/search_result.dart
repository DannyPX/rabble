import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rabble/components/lists/song_row_list.dart';
import 'package:rabble/services/search/search_service.dart';

import '../../providers.dart';

class SearchResult extends HookConsumerWidget {
  late final searchProvider = StateProvider.autoDispose(
      (ref) => SearchService(ref.read(ytProvider), query));
  final String query;

  SearchResult({required this.query, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(searchProvider);
    useListenable(service);

    if (service.error) {
      return Text(service.errorMessage);
    }

    return Search(query: query, service: service);
  }
}

class Search extends StatelessWidget {
  final String query;
  final SearchService service;

  const Search({required this.query, required this.service, Key? key})
      : super(key: key);

  Widget build(BuildContext context) {
    final videos = service.videos;
    return SongRowList(list: videos, live: true);
  }
}
