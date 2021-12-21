import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    Key? key,
    required this.page,
  }) : super(key: key);

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: cBackgroundColor,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 150.0,
                ),
                child: page,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
