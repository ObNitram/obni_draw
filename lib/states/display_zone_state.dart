import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:obni_draw/core/drawable/drawable.dart";
import "package:obni_draw/core/utils/rect_transform.dart";
import "package:obni_draw/ui/selected_indicator.dart";

class DisplayZoneState {
  final List<IDrawable> _allPositionedDrawable = [];
  IDrawable? _selectedDrawable;

  bool isMovingSelected = false;

  Iterable<Widget> getPositioned() {
    return _allPositionedDrawable.map((e) {
      if (e == _selectedDrawable) {
        return SelectedIndicator(
          drawable: e,
          onRectTransformModifyStart: () => isMovingSelected = true,
          onRectTransformUpdated: e.setPosition,
          onRectTransformModifyEnd: () => isMovingSelected = false,
        );
      } else {
        return _build(e);
      }
    });
  }

  void add(IDrawable drawableHandler) {
    _allPositionedDrawable.add(drawableHandler);
  }

  void select(Offset position) {
    if (isMovingSelected) return;

    for (var e in _allPositionedDrawable.reversed) {
      if (e.getPosition().containsOffset(position)) {
        _selectedDrawable = e;
        return;
      }
    }

    _selectedDrawable = null;
  }

  void deselect() {
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
