import 'package:flutter/material.dart';

import '../../constants.dart';

class SecondTitle extends StatelessWidget {
  const SecondTitle({Key? key, required this.title, required this.buttonTitle})
      : super(key: key);

  final String title;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonTitle.isNotEmpty
          ? const EdgeInsets.only(
              bottom: 8.0,
              top: 0.0,
            )
          : const EdgeInsets.only(bottom: 11.0, top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: fTitle2Style),
          if (buttonTitle.isNotEmpty)
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(buttonTitle, style: fSmallTextButtonStyle),
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
