import "dart:math";

import "package:flutter/material.dart";
import "package:obni_draw/ui/drawable/drawable.dart";
import "package:obni_draw/ui/drawable/drawable_type.dart";

class DrawableRectType implements IDrawableType {
  final Color? _color;

  DrawableRectType({Color? color}) : _color = color;

  @override
  IDrawable createDrawable() {
    return DrawableRect(color: _color);
  }
}

class DrawableRect implements IDrawable {
  Offset _startPosition = Offset.zero;
  Offset _currentPosition = Offset.zero;
  bool _isSelected = false;
  final Color _color;

  DrawableRect({Color? color}) : _color = color ?? Colors.black12;

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

    if (_startPosition == _currentPosition) {
      _startPosition = Offset.zero;
      _currentPosition = Offset.zero;
      return false;
    }

    return true;
  }

  @override
  void onSelected() {
    _isSelected = !_isSelected;
  }

  @override
  (Offset, Offset, Widget) draw() {
    final double left = min(_startPosition.dx, _currentPosition.dx);
    final double top = min(_startPosition.dy, _currentPosition.dy);
    final double width = (_startPosition.dx - _currentPosition.dx).abs();
    final double height = (_startPosition.dy - _currentPosition.dy).abs();

    return (
      Offset(left, top),
      Offset(width, height),
      Container(
        decoration: BoxDecoration(
          color: _color,
          border: Border.all(
            color: _isSelected ? Colors.blue : Colors.black,
            width: 2.0,
          ),
        ),
      )
    );
  }
}
