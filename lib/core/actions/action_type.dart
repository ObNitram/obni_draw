import "package:flutter/widgets.dart";

abstract class ActionType {
  Positioned draw() => Positioned(child: Container());

  void onEnable() {}

  void onDisable() {}

  void onPointerDown(PointerDownEvent event) {}

  void onPointerMove(PointerMoveEvent event) {}

  void onPointerUp(PointerUpEvent event) {}

  IconData get icon;

  String get name;
}
