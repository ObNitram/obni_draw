import "package:flutter/widgets.dart";
import "package:obni_draw/core/utils.dart";

import "drawable/drawable.dart";

class DrawableDisplayZone {
  final List<IDrawable> _allPositionedDrawable = [];

  Iterable<Positioned> getPositioned() {
    return _allPositionedDrawable.map((e) => build(e));
  }

  void add(IDrawable drawableHandler) {
    _allPositionedDrawable.add(drawableHandler);
  }
}
