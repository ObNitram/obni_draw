import "dart:math";

import "package:flutter/widgets.dart";

class Rect {
  final double left;
  final double top;
  final double width;
  final double height;

  const Rect(
      {required this.left,
      required this.top,
      required this.width,
      required this.height});

  Rect.fromOffset(Offset startPosition, Offset endPosition)
      : left = min(startPosition.dx, endPosition.dx),
        top = min(startPosition.dy, endPosition.dy),
        width = (startPosition.dx - endPosition.dx).abs(),
        height = (startPosition.dy - endPosition.dy).abs();

  static const Rect zero = Rect(left: 0, top: 0, width: 0, height: 0);

  Positioned toPositioned({required Widget child}) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: child,
    );
  }

  double get area => width * height;
}
