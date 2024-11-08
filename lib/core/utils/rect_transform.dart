import "dart:math";

import "package:flutter/widgets.dart";

final class Vec2 {
  final double x;
  final double y;

  const Vec2(this.x, this.y);

  Vec2.fromOffset(Offset offset)
      : x = offset.dx,
        y = offset.dy;

  Vec2 operator +(Vec2 other) {
    return Vec2(x + other.x, y + other.y);
  }

  Vec2 operator -(Vec2 other) {
    return Vec2(x - other.x, y - other.y);
  }

  bool operator <(Vec2 other) {
    return x < other.x && y < other.y;
  }

  bool operator >(Vec2 other) {
    return x > other.x && y > other.y;
  }

  bool operator <=(Vec2 other) {
    return x <= other.x && y <= other.y;
  }

  bool operator >=(Vec2 other) {
    return x >= other.x && y >= other.y;
  }

  double magnitude() {
    return sqrt(x * x + y * y);
  }
}

final class RectTransform {
  final Vec2 a;
  final Vec2 b;

  double get width => b.x - a.x;

  double get height => b.y - a.y;

  const RectTransform({required this.a, required this.b}) : assert(a <= b);

  RectTransform.fromValue(
      {required double ax,
      required double ay,
      required double bx,
      required double by})
      : a = Vec2(min(ax, bx), min(ay, by)),
        b = Vec2(max(ax, bx), max(ay, by));

  RectTransform copyWith({
    Vec2? a,
    Vec2? b,
  }) {
    Vec2 newA = a ?? this.a;
    Vec2 newB = b ?? this.b;

    if (!(newA <= newB)) {
      newA = Vec2(min(newA.x, newB.x), min(newA.y, newB.y));
      newB = Vec2(max(newA.x, newB.x), max(newA.y, newB.y));
    }

    return RectTransform(
      a: newA,
      b: newB,
    );
  }

  static final RectTransform zero = RectTransform(
    a: Vec2(0, 0),
    b: Vec2(0, 0),
  );

  Positioned toPositioned({required Widget child}) {
    assert(a <= b);
    return Positioned(
      left: a.x,
      top: a.y,
      width: width,
      height: height,
      child: child,
    );
  }

  double get area => width * height;

  bool containsOffset(Offset offset) {
    final bool withinX = offset.dx >= a.x && offset.dx <= b.x;
    final bool withinY = offset.dy >= a.y && offset.dy <= b.y;
    return withinX && withinY;
  }

  bool intersects(RectTransform other) {
    final bool noOverlapX = other.b.x < a.x || other.a.x > b.x;
    final bool noOverlapY = other.b.y < a.y || other.a.y > b.y;
    return !(noOverlapX || noOverlapY);
  }

  @override
  String toString() {
    return "RectTransform(a: $a, b: $b, width: $width, height: $height)";
  }
}
