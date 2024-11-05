import "package:flutter/material.dart";
import "package:obni_draw/core/position.dart";

abstract interface class IDrawable {
  Widget draw();

  Rect getPosition();
}
