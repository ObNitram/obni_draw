import "package:flutter/widgets.dart";
import "package:obni_draw/core/position.dart";
import "package:obni_draw/ui/drawable/drawable.dart";

Positioned build(IDrawable drawable) {
  Rect position = drawable.getPosition();

  return Positioned(
    left: position.left,
    top: position.top,
    width: position.width,
    height: position.height,
    child: drawable.draw(),
  );
}
