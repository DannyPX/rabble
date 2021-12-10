import 'package:flutter/material.dart';
import 'package:rabble/components/search/search_result.dart';
import 'package:rabble/components/search/suggestion_list.dart';

import '../../constants.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String query = '';
  bool focusInput = false;
  final TextEditingController _txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FocusScope(
          child: Focus(
            onFocusChange: (focus) => setState(() => focusInput = focus),
            child: TextField(
              controller: _txt,
              style: TextStyle(color: cTextPrimaryColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: cButtonBackgroundColor,
                hintText: "Search for some music",
                hintStyle: fUnderTitleStyle,
                prefixIcon:
                    const Icon(Icons.search, color: cTextSecondaryColor),
                border: InputBorder.none,
              ),
              onChanged: (string) {
                setState(() => query = string);
              },
            ),
          ),
        ),
        if (query.isNotEmpty && focusInput)
          // TODO on top of view
          SizedBox(
            child: SuggestionList(query, _changeQuery),
            height: 500,
          ),
        if (!focusInput) SearchResult(query: query)
      ],
    );
  }

  _changeQuery(string) {
    setState(() => query = string);
    _txt.text = query;
    _txt.selection =
        TextSelection.fromPosition(TextPosition(offset: _txt.text.length));
  }
}
