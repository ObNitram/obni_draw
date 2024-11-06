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

  Offset _startPosition = Offset.zero;
  Offset _currentPosition = Offset.zero;

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
  Positioned draw() {
    RectTransform rect =
        RectTransform.fromOffset(_startPosition, _currentPosition);

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
  void onPointerDown(PointerDownEvent event) {
    _startPosition = event.localPosition;
    _currentPosition = event.localPosition;
  }

  @override
  void onPointerMove(PointerMoveEvent event) {
    _currentPosition = event.localPosition;
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    _currentPosition = event.localPosition;

    if (RectTransform.fromOffset(_startPosition, _currentPosition).area <
        minAreaToDisplay) {
      _startPosition = Offset.zero;
      _currentPosition = Offset.zero;
      return;
    }

    createDrawable();
  }

  void createDrawable() {
    _displayZoneState.add(DrawableRect(
        position: RectTransform.fromOffset(_startPosition, _currentPosition),
        borderColor: _borderColor,
        backgroundColor: _backgroundColor,
        radius: _radius));
  }

  @override
  IconData get icon => _iconData;

  @override
  String get name => _name;
}
