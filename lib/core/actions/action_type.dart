import "package:flutter/widgets.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

abstract class ActionType {
  Positioned draw() => Positioned(child: Container());

  void onEnable() {}

  void onDisable() {}

  void onPointerDown(DragStartDetails event, Vec2 offset) {}

  void onPointerMove(DragUpdateDetails event, Vec2 offset) {}

  void onPointerUp(DragEndDetails event, Vec2 offset) {}

  IconData get icon;

  String get name;
}
