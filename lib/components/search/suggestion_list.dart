import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../shared.dart';
import '../../constants.dart';

class SuggestionList extends HookConsumerWidget {
  final String query;
  final void Function(String) callback;

  const SuggestionList(this.query, this.callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yt = YoutubeExplode();
    final debQuery = useDebounce(query, const Duration(milliseconds: 200));

    final suggestions = useMemoFuture(
        () => yt.search.getQuerySuggestions(query),
        initialData: const <String>[],
        keys: [debQuery]);

    return ListView.builder(
      itemCount: suggestions.data!.length,
      itemBuilder: (context, index) {
        final result = suggestions.data![index];
        return MaterialButton(
          color: cButtonBackgroundColor,
          onPressed: () {
            callback(result);
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 10,
            leading: const Icon(
              Icons.search,
              color: cTextPrimaryColor,
            ),
            title: Text(
              result,
              style: TextStyle(color: cTextPrimaryColor),
            ),
          ),
        );
      },
    );
  }
}
