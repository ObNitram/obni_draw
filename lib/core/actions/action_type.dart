import "package:flutter/widgets.dart";

abstract class ActionType {
  Positioned draw() => Positioned(child: Container());

  void onEnable() {}

  void onDisable() {}

  void onPointerDown(DragStartDetails event) {}

  void onPointerMove(DragUpdateDetails event) {}

  void onPointerUp(DragEndDetails event) {}

  IconData get icon;

  String get name;
}
