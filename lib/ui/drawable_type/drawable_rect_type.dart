import "package:flutter/material.dart";
import "package:obni_draw/core/position.dart";
import "package:obni_draw/ui/drawable/drawable.dart";
import "package:obni_draw/ui/drawable/drawable_rect.dart";
import "package:obni_draw/ui/drawable_type/drawable_type.dart";

class DrawableRectType implements IDrawableType {
  final Color _borderColor;
  final Color _backgroundColor;

  Offset _startPosition = Offset.zero;
  Offset _currentPosition = Offset.zero;

  static const double minAreaToDisplay = 0.2;

  DrawableRectType({required Color borderColor, required Color backgroundColor})
      : _borderColor = borderColor,
        _backgroundColor = backgroundColor;

  @override
  Positioned draw() {
    Rect rect = Rect.fromOffset(_startPosition, _currentPosition);

    if (rect.area < minAreaToDisplay) {
      return Positioned(child: Container());
    }

    return rect.toPositioned(
        child: Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(
          color: _borderColor,
          width: 2.0,
        ),
      ),
    ));
  }

  @override
  bool onPointerDown(PointerDownEvent event) {
    _startPosition = event.localPosition;
    _currentPosition = event.localPosition;
    return false;
  }

  @override
  bool onPointerMove(PointerMoveEvent event) {
    _currentPosition = event.localPosition;
    return false;
  }

  @override
  bool onPointerUp(PointerUpEvent event) {
    _currentPosition = event.localPosition;

    if (Rect.fromOffset(_startPosition, _currentPosition).area <
        minAreaToDisplay) {
      _startPosition = Offset.zero;
      _currentPosition = Offset.zero;
      return false;
    }

    return true;
  }

  @override
  IDrawable createDrawable() {
    return DrawableRect(
        position: Rect.fromOffset(_startPosition, _currentPosition),
        borderColor: _borderColor,
        backgroundColor: _backgroundColor);
  }
}
