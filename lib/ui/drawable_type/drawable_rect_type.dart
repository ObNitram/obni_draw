import "package:flutter/material.dart";
import "package:obni_draw/core/transform.dart";
import "package:obni_draw/ui/drawable/drawable_rect.dart";
import "package:obni_draw/ui/drawable_display_zone.dart";
import "package:obni_draw/ui/drawable_type/drawable_type.dart";

class DrawableRectType extends DrawableType {
  final DrawableDisplayZone _drawableDisplayZone;
  final Color _borderColor;
  final Color _backgroundColor;

  Offset _startPosition = Offset.zero;
  Offset _currentPosition = Offset.zero;

  static const double minAreaToDisplay = 0.2;

  DrawableRectType(
      {required Color borderColor,
      required Color backgroundColor,
      required DrawableDisplayZone drawableDisplayZone})
      : _borderColor = borderColor,
        _backgroundColor = backgroundColor,
        _drawableDisplayZone = drawableDisplayZone;

  @override
  Positioned draw() {
    RectTransform rect =
        RectTransform.fromOffset(_startPosition, _currentPosition);

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
    _drawableDisplayZone.add(DrawableRect(
        position: RectTransform.fromOffset(_startPosition, _currentPosition),
        borderColor: _borderColor,
        backgroundColor: _backgroundColor));
  }
}
