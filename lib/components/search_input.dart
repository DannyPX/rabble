import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../constants.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: SearchField(
        searchInputDecoration: InputDecoration(
          filled: true,
          fillColor: cButtonBackgroundColor,
          hintText: "Search for some music",
          hintStyle: fUnderTitleStyle,
          prefixIcon: const Icon(Icons.search, color: cTextSecondaryColor),
          border: InputBorder.none,
        ),
        searchStyle: const TextStyle(
          color: cTextPrimaryColor,
        ),
        itemHeight: 42.0,
        suggestions: const [
          "Stromae Santé",
          "Stromae Santé Lyrics",
        ],
      ),
    );
  }
}
