import "package:flutter/material.dart";
import "package:obni_draw/core/actions/action_type.dart";
import "package:obni_draw/core/drawable/drawable_rect.dart";

import "package:obni_draw/core/utils/rect_transform.dart";

import "package:obni_draw/states/display_zone_state.dart";

class DrawableRectAction extends ActionType {
  final DisplayZoneState _displayZoneState;
  final Color _borderColor;
  final Color _backgroundColor;
  final double _radius;
  final IconData _iconData;
  final String _name;

  Vec2 _startPosition = Vec2.zero;
  Vec2 _currentPosition = Vec2.zero;

  static const double minAreaToDisplay = 0.2;

  DrawableRectAction(
      {required Color borderColor,
      required Color backgroundColor,
      required DisplayZoneState displayZoneState,
      required double radius,
      required IconData iconData,
      required String name})
      : _borderColor = borderColor,
        _backgroundColor = backgroundColor,
        _displayZoneState = displayZoneState,
        _radius = radius,
        _iconData = iconData,
        _name = name;

  @override
  void onEnable() {
    _startPosition = Vec2.zero;
    _currentPosition = Vec2.zero;
  }

  @override
  void onDisable() {
    _startPosition = Vec2.zero;
    _currentPosition = Vec2.zero;
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
    _currentPosition = event.localPosition.toVec2();

    final rectTransform =
        RectTransform.fromPoint(_startPosition, _currentPosition);

    if (rectTransform.area < minAreaToDisplay) {
      _startPosition = Vec2.zero;
      _currentPosition = Vec2.zero;
      return;
    }

    createDrawable(rectTransform.copyWithOffset(-offset));
  }

  void createDrawable(RectTransform transform) {
    _displayZoneState.add(DrawableRect(
        position: transform,
        borderColor: _borderColor,
        backgroundColor: _backgroundColor,
        radius: _radius));
  }

  @override
  IconData get icon => _iconData;

  @override
  String get name => _name;
}
