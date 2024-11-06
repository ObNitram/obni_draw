import "package:flutter/material.dart";

import "package:obni_draw/ui/drawable_display_zone.dart";
import "package:obni_draw/ui/drawable_type/drawable_type.dart";

class Selector extends DrawableType {
  final DrawableDisplayZone _drawableDisplayZone;

  Selector({required DrawableDisplayZone drawableDisplayZone})
      : _drawableDisplayZone = drawableDisplayZone;

  @override
  void onDisable() {
    _drawableDisplayZone.deselect();
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    _drawableDisplayZone.select(event.localPosition);
  }
}
