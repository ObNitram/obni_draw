import "package:flutter/widgets.dart";
import "package:obni_draw/ui/drawable/drawable.dart";

abstract interface class IDrawableType {
  Positioned draw();

  bool onPointerDown(PointerDownEvent event);

  bool onPointerMove(PointerMoveEvent event);

  bool onPointerUp(PointerUpEvent event);

  IDrawable createDrawable();
}
