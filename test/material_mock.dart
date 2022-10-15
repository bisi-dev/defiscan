import "package:flutter/material.dart";

Widget materialWidget(Widget child) {
  return MaterialApp(
    home: MediaQuery(
        data: const MediaQueryData(
          size: Size(1080.0, 1920.0),
        ),
        child: child),
  );
}
