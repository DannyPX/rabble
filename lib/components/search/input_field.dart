import 'package:flutter/material.dart';
import 'package:rabble/components/search/suggestion_list.dart';

import '../../constants.dart';

class InputField extends StatefulWidget {
  const InputField({Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
      ],
    );
  }

  _changeQuery(string) {
    setState(() => query = string);
    _txt.text = query;
  }
}
