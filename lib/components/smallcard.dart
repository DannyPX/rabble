import 'package:flutter/material.dart';
import 'package:rabble/constants.dart';

class SmallCard extends StatefulWidget {
  const SmallCard({Key? key}) : super(key: key);

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {},
        child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/onboarding.jpg',
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        Expanded(
                            flex: 5,
                            child: ListTile(
                              title: Text(
                                "Title",
                                style: fCardTitleStyle,
                              ),
                              subtitle:
                                  Text("Subtitle", style: fCardUnderTitleStyle),
                            )),
                        Expanded(
                            flex: 5,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: cTextPrimaryColor,
                                  ),
                                  SizedBox(width: 8),
                                ]))
                      ])))
            ])),
      ),
    );
  }
}
