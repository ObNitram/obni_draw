import "package:flutter/material.dart";
import "package:obni_draw/ui/drawable/drawable.dart";
import "package:obni_draw/ui/drawable_display_zone.dart";
import "package:obni_draw/ui/drawable_type/drawable_type.dart";

class Selector implements IDrawableType {
  final DrawableDisplayZone _drawableDisplayZone;

  Selector({required DrawableDisplayZone drawableDisplayZone})
      : _drawableDisplayZone = drawableDisplayZone;

  @override
  IDrawable createDrawable() {
    throw UnimplementedError();
  }

  @override
  Positioned draw() {
    return Positioned(child: Container());
  }

  @override
  bool onPointerDown(PointerDownEvent event) {
    return false;
  }

  @override
  bool onPointerMove(PointerMoveEvent event) {
    return false;
  }

  @override
  bool onPointerUp(PointerUpEvent event) {
    _drawableDisplayZone.select(event.localPosition);
    return false;
  }
}
