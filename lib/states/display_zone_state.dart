import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "package:obni_draw/core/drawable/drawable.dart";
import "package:obni_draw/core/utils/rect_transform.dart";
import "package:obni_draw/ui/selected_indicator.dart";

class DisplayZoneState {
  final List<IDrawable> _allPositionedDrawable = [];
  Set<IDrawable> _selectedDrawable = {};

  final Function() notifyListeners;

  DisplayZoneState({required this.notifyListeners});

  Iterable<Widget> getPositioned(double scale, Vec2 position) {
    List<Widget> tmp = [];

    tmp.addAll(_allPositionedDrawable.map((e) {
      return _build(e, scale, position);
    }));

    tmp.addAll(_selectedDrawable.map((e) => SelectedIndicator(
          drawable: e,
          offset: position,
          onRectTransformUpdated: (rectTransform) {
            e.setPosition(rectTransform);
            notifyListeners();
          },
        )));

    return tmp;
  }

  void add(IDrawable drawableHandler) {
    _allPositionedDrawable.add(drawableHandler);
  }

  void select(Iterable<IDrawable> list) {
    _selectedDrawable.addAll(list);
  }

  void deselect(Iterable<IDrawable> list) {
    _selectedDrawable.removeAll(list);
  }

  void deselectAll() {
    _selectedDrawable = {};
  }

  Positioned _build(IDrawable drawable, double scale, Vec2 position) {
    RectTransform rect = drawable.getPosition();
    double left = (rect.topLeft.x + position.x) * scale;
    double top = (rect.topLeft.y + position.y) * scale;
    double width = rect.width * scale;
    double height = rect.height * scale;

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: drawable.draw(),
    );
  }

  Iterable<IDrawable> getDrawableInRect(RectTransform transform) {
    List<IDrawable> list = [];

    for (var drawable in _allPositionedDrawable) {
      if (transform.contains(drawable.getPosition())) {
        list.add(drawable);
      }
    }

    return list;
  }

  Iterable<IDrawable> getDrawableOnPosition(Vec2 position) {
    List<IDrawable> list = [];

    for (var drawable in _allPositionedDrawable) {
      if (drawable.getPosition().containsVec2(position)) {
        list.add(drawable);
      }
    }

    return list;
  }
}
