import "package:flutter/material.dart";
import "package:obni_draw/core/transform.dart";
import "package:obni_draw/ui/drawable/drawable.dart";

class DrawableRect implements IDrawable {
  final RectTransform _position;
  final Color _borderColor;
  final Color _backgroundColor;

  DrawableRect(
      {required RectTransform position,
      required Color borderColor,
      required Color backgroundColor})
      : _position = position,
        _borderColor = borderColor,
        _backgroundColor = backgroundColor;

  @override
  Widget draw() {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(
          color: _borderColor,
          width: 2.0,
        ),
      ),
    );
  }

  @override
  RectTransform getPosition() {
    return _position;
  }
}
