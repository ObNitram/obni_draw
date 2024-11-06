import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:obni_draw/core/transform.dart";
import "package:obni_draw/ui/slected_indicator.dart";

import "drawable/drawable.dart";

class DrawableDisplayZone {
  final List<IDrawable> _allPositionedDrawable = [];
  IDrawable? _selectedDrawable;

  Iterable<Positioned> getPositioned() {
    return _allPositionedDrawable.map((e) {
      if (e == _selectedDrawable) {
        return buildSelected(e);
      } else {
        return _build(e);
      }
    });
  }

  void add(IDrawable drawableHandler) {
    _allPositionedDrawable.add(drawableHandler);
  }

  void select(Offset position) {
    for (var e in _allPositionedDrawable.reversed) {
      if (e.getPosition().containsOffset(position)) {
        _selectedDrawable = e;
        return;
      }
    }

    _selectedDrawable = null;
  }

  Positioned _build(IDrawable drawable) {
    RectTransform position = drawable.getPosition();

    return Positioned(
      left: position.x,
      top: position.y,
      width: position.width,
      height: position.height,
      child: drawable.draw(),
    );
  }
}
