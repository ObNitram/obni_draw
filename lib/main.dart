import "package:flutter/material.dart";

import "package:obni_draw/ui/drawable_zone.dart";

void main() {
  //debugRepaintRainbowEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: Scaffold(body: DrawableZone()),
    );
  }
}
