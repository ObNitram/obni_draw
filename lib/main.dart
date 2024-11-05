import "package:flutter/material.dart";
import "package:obni_draw/ui/drawable_zone.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
      ),
      home: const Scaffold(body: DrawableZone()),
    );
  }
}
