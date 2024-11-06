import "dart:math";

import "package:flutter/widgets.dart";

final class RectTransform {
  final double x;
  final double y;
  final double width;
  final double height;

  double get xWidth => x + width;

  double get yHeight => y + height;

  const RectTransform({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  RectTransform.fromOffset(Offset startPosition, Offset endPosition)
      : x = min(startPosition.dx, endPosition.dx),
        y = min(startPosition.dy, endPosition.dy),
        width = (startPosition.dx - endPosition.dx).abs(),
        height = (startPosition.dy - endPosition.dy).abs();

  RectTransform copyWith({
    double? x,
    double? y,
    double? width,
    double? height,
  }) {
    return RectTransform(
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  static const RectTransform zero =
      RectTransform(x: 0, y: 0, width: 0, height: 0);

  Positioned toPositioned({required Widget child}) {
    return Positioned(
      left: x,
      top: y,
      width: width,
      height: height,
      child: child,
    );
  }

  double get area => width * height;

  bool containsOffset(Offset offset) {
    final bool withinX = offset.dx >= x && offset.dx <= xWidth;
    final bool withinY = offset.dy >= y && offset.dy <= yHeight;
    return withinX && withinY;
  }

  bool intersects(RectTransform other) {
    final bool noOverlapX = other.xWidth < x || other.x > xWidth;
    final bool noOverlapY = other.yHeight < y || other.y > yHeight;
    return !(noOverlapX || noOverlapY);
  }

  @override
  String toString() {
    return "Transform(x: $x, y: $y, width: $width, height: $height)";
  }
}
