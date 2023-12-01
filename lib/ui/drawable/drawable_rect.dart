import "dart:math";

import "package:flutter/material.dart";
import "package:obni_draw/ui/drawable/drawable.dart";

class DrawableRect implements IDrawable {
  Offset _startPosition = Offset.zero;
  Offset _currentPosition = Offset.zero;

  @override
  Positioned? onPointerDown(PointerDownEvent event) {
    _startPosition = event.localPosition;
    _currentPosition = event.localPosition;
    return null;
  }

  @override
  Positioned? onPointerMove(PointerMoveEvent event) {
    _currentPosition = event.localPosition;
    return null;
  }

  @override
  Positioned? onPointerUp(PointerUpEvent event) {
    _currentPosition = event.localPosition;
    return draw();
  }

  @override
  Positioned draw() {
    final double left = min(_startPosition.dx, _currentPosition.dx);
    final double top = min(_startPosition.dy, _currentPosition.dy);
    final double width = (_startPosition.dx - _currentPosition.dx).abs();
    final double height = (_startPosition.dy - _currentPosition.dy).abs();

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF000000),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
