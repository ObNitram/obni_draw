import "package:flutter/material.dart";
import "package:obni_draw/core/actions/action_type.dart";
import "package:obni_draw/core/drawable/drawable.dart";
import "package:obni_draw/core/drawable/drawable_rect.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

import "package:obni_draw/states/display_zone_state.dart";

class Selector extends ActionType {
  final DisplayZoneState _displayZoneState;

  Vec2 _startPosition = Vec2.zero;
  Vec2 _currentPosition = Vec2.zero;

  static const double minAreaToDisplay = 0.2;
  static const _borderColor = Color(0xFF3E5EE8);
  static const _backgroundColor = Color(0x00ffffff);
  static const double _radius = 4;

  Selector({required DisplayZoneState drawableDisplayZone})
      : _displayZoneState = drawableDisplayZone;

  @override
  void onEnable() {
    _startPosition = Vec2.zero;
    _currentPosition = Vec2.zero;
  }

  @override
  void onDisable() {
    _startPosition = Vec2.zero;
    _currentPosition = Vec2.zero;
    _displayZoneState.deselectAll();
  }

  @override
  Positioned draw() {
    RectTransform rect =
        RectTransform.fromPoint(_startPosition, _currentPosition);

    if (rect.area < minAreaToDisplay) {
      return Positioned(child: Container());
    }

    return rect.toPositioned(
        child: DrawableRect(
                position: RectTransform.zero,
                borderColor: _borderColor,
                backgroundColor: _backgroundColor,
                radius: _radius)
            .draw());
  }

  @override
  void onPointerDown(event, offset) {
    _startPosition = event.localPosition.toVec2();
    _currentPosition = event.localPosition.toVec2();
  }

  @override
  void onPointerMove(event, offset) {
    _currentPosition = event.localPosition.toVec2();
  }

  @override
  void onPointerUp(event, offset) {
    _trySelect(offset);
    _startPosition = Vec2.zero;
    _currentPosition = Vec2.zero;
  }

  @override
  String get name => "Selector";

  @override
  IconData get icon => Icons.select_all;

  void _trySelect(Vec2 offset) {
    var rectTransform = RectTransform.fromPoint(
        _startPosition - offset, _currentPosition - offset);

    Iterable<IDrawable> drawableToSelect = [];

    if (rectTransform.area < minAreaToDisplay) {
      drawableToSelect =
          _displayZoneState.getDrawableOnPosition(rectTransform.topLeft);
    } else {
      drawableToSelect = _displayZoneState.getDrawableInRect(rectTransform);
    }

    if (drawableToSelect.isEmpty) {
      _displayZoneState.deselectAll();
    } else {
      _displayZoneState.select(drawableToSelect);
    }
  }
}
