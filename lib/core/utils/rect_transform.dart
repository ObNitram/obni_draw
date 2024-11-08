import "dart:math";

import "package:flutter/widgets.dart";

extension Vec2Extension on Offset {
  Vec2 toVec2() => Vec2(dx, dy);
}

final class Vec2 {
  final double x;
  final double y;

  const Vec2(this.x, this.y);

  static const zero = Vec2(0, 0);

  Vec2.fromOffset(Offset offset)
      : x = offset.dx,
        y = offset.dy;

  Vec2 operator +(Vec2 other) => Vec2(x + other.x, y + other.y);

  Vec2 operator -(Vec2 other) => Vec2(x - other.x, y - other.y);

  Vec2 operator -() => Vec2(-x, -y);

  bool operator <(Vec2 other) => (x < other.x && y < other.y);

  bool operator >(Vec2 other) => (x > other.x && y > other.y);

  bool operator <=(Vec2 other) => (x <= other.x && y <= other.y);

  bool operator >=(Vec2 other) => (x >= other.x && y >= other.y);

  double get magnitudeSquared => (x * x + y * y);

  double get magnitude => sqrt(magnitudeSquared);
}

final class RectTransform {
  final Vec2 topLeft;
  final Vec2 bottomRight;

  double get width => bottomRight.x - topLeft.x;

  double get height => bottomRight.y - topLeft.y;

  RectTransform({required this.topLeft, required this.bottomRight})
      : assert(topLeft <= bottomRight);

  RectTransform.fromPoint(Vec2 a, Vec2 b)
      : topLeft = Vec2(min(a.x, b.x), min(a.y, b.y)),
        bottomRight = Vec2(max(a.x, b.x), max(a.y, b.y));

  RectTransform copyWith({double? ax, double? ay, double? bx, double? by}) =>
      RectTransform.fromPoint(
        Vec2(ax ?? topLeft.x, ay ?? topLeft.y),
        Vec2(bx ?? bottomRight.x, by ?? bottomRight.y),
      );

  RectTransform copyWithOffset(Vec2 offset) {
    return RectTransform(
        topLeft: topLeft + offset, bottomRight: bottomRight + offset);
  }

  static final RectTransform zero =
      RectTransform(topLeft: Vec2.zero, bottomRight: Vec2.zero);

  Positioned toPositioned({required Widget child}) {
    assert(topLeft <= bottomRight);
    return Positioned(
      left: topLeft.x,
      top: topLeft.y,
      width: width,
      height: height,
      child: child,
    );
  }

  double get area {
    var a = width * height;
    assert(a >= 0);
    return a;
  }

  bool containsOffset(Offset offset) {
    final bool withinX = offset.dx >= topLeft.x && offset.dx <= bottomRight.x;
    final bool withinY = offset.dy >= topLeft.y && offset.dy <= bottomRight.y;
    return withinX && withinY;
  }

  bool containsVec2(Vec2 vec) {
    final bool withinX = vec.x >= topLeft.x && vec.x <= bottomRight.x;
    final bool withinY = vec.y >= topLeft.y && vec.y <= bottomRight.y;
    return withinX && withinY;
  }

  bool intersects(RectTransform other) {
    final bool noOverlapX =
        other.bottomRight.x < topLeft.x || other.topLeft.x > bottomRight.x;
    final bool noOverlapY =
        other.bottomRight.y < topLeft.y || other.topLeft.y > bottomRight.y;
    return !(noOverlapX || noOverlapY);
  }

  bool contains(RectTransform other) {
    return containsVec2(other.topLeft) && containsVec2(other.bottomRight);
  }

  @override
  String toString() {
    return "RectTransform(a: $topLeft, b: $bottomRight, width: $width, height: $height)";
  }
}
