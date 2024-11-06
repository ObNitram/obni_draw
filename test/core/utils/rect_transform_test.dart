import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

void main() {
  group("RectTransform copyWith", () {
    test("should copy with new values", () {
      final rect = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final newRect = rect.copyWith(a: Vec2(2, 3), b: Vec2(4, 5));

      expect(newRect.a.x, 2);
      expect(newRect.a.y, 3);
      expect(newRect.b.x, 4);
      expect(newRect.b.y, 5);
    });

    test("should copy with same values", () {
      final rect = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final newRect = rect.copyWith();

      expect(newRect.a.x, 1);
      expect(newRect.a.y, 2);
      expect(newRect.b.x, 3);
      expect(newRect.b.y, 4);
    });
  });

  group("RectTransform area", () {
    test("should calculate the area", () {
      final rect = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final area = rect.area;

      expect(area, 4);
    });

    test("should calculate the area with negative values", () {
      final rect = RectTransform(a: Vec2(-1, -2), b: Vec2(3, 4));
      final area = rect.area;

      expect(area, 24);
    });

    test("should calculate the area with zero values", () {
      final rect = RectTransform(a: Vec2(0, 0), b: Vec2(0, 0));
      final area = rect.area;

      expect(area, 0);
    });
  });

  group("RectTransform containsOffset", () {
    test("should check if contains offset", () {
      final rect = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final contains = rect.containsOffset(Offset(2, 3));

      expect(contains, true);
    });

    test("should check if does not contain offset", () {
      final rect = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final contains = rect.containsOffset(Offset(4, 5));

      expect(contains, false);
    });
  });

  group("RectTransform intersects", () {
    test("should check if intersects", () {
      final rect1 = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final rect2 = RectTransform(a: Vec2(2, 3), b: Vec2(4, 5));
      final intersects = rect1.intersects(rect2);

      expect(intersects, true);
    });

    test("should check if does not intersect", () {
      final rect1 = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final rect2 = RectTransform(a: Vec2(4, 5), b: Vec2(6, 7));
      final intersects = rect1.intersects(rect2);

      expect(intersects, false);
    });
  });

  group("RectTransform toPositioned", () {
    test("should convert to Positioned widget", () {
      final rect = RectTransform(a: Vec2(1, 2), b: Vec2(3, 4));
      final positioned = rect.toPositioned(child: Container());

      expect(positioned.left, 1);
      expect(positioned.top, 2);
      expect(positioned.width, 2);
      expect(positioned.height, 2);
    });
  });
}
