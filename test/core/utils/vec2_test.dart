import "package:flutter_test/flutter_test.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

void main() {
  group("Vec2 addition operator", () {
    test("should add two vectors", () {
      final vec1 = Vec2(1, 2);
      final vec2 = Vec2(3, 4);
      final result = vec1 + vec2;

      expect(result.x, 4);
      expect(result.y, 6);
    });

    test("should add negative vectors", () {
      final vec1 = Vec2(-1, -2);
      final vec2 = Vec2(-3, -4);
      final result = vec1 + vec2;

      expect(result.x, -4);
      expect(result.y, -6);
    });

    test("should add zero vectors", () {
      final vec1 = Vec2(0, 0);
      final vec2 = Vec2(0, 0);
      final result = vec1 + vec2;

      expect(result.x, 0);
      expect(result.y, 0);
    });
  });

  group("Vec2 subtraction operator", () {
    test("should subtract two vectors", () {
      final vec1 = Vec2(5, 7);
      final vec2 = Vec2(2, 3);
      final result = vec1 - vec2;

      expect(result.x, 3);
      expect(result.y, 4);
    });

    test("should subtract negative vectors", () {
      final vec1 = Vec2(-5, -7);
      final vec2 = Vec2(-2, -3);
      final result = vec1 - vec2;

      expect(result.x, -3);
      expect(result.y, -4);
    });

    test("should subtract zero vectors", () {
      final vec1 = Vec2(0, 0);
      final vec2 = Vec2(0, 0);
      final result = vec1 - vec2;

      expect(result.x, 0);
      expect(result.y, 0);
    });
  });

  group("Vec2 magnitude", () {
    test("should calculate the magnitude of a vector", () {
      final vec = Vec2(3, 4);
      final result = vec.magnitude;

      expect(result, 5);
    });

    test("should calculate the magnitude of a negative vector", () {
      final vec = Vec2(-3, -4);
      final result = vec.magnitude;

      expect(result, 5);
    });

    test("should calculate the magnitude of a zero vector", () {
      final vec = Vec2(0, 0);
      final result = vec.magnitude;

      expect(result, 0);
    });
  });

  group("Vec2 less than operator", () {
    test("should compare two vectors", () {
      final vec1 = Vec2(1, 2);
      final vec2 = Vec2(3, 4);

      expect(vec1 < vec2, true);
      expect(vec2 < vec1, false);
    });

    test("should compare negative vectors", () {
      final vec1 = Vec2(-1, -2);
      final vec2 = Vec2(-3, -4);

      expect(vec1 < vec2, false);
      expect(vec2 < vec1, true);
    });

    test("should compare zero vectors", () {
      final vec1 = Vec2(0, 0);
      final vec2 = Vec2(0, 0);

      expect(vec1 < vec2, false);
      expect(vec2 < vec1, false);
    });
  });

  group("Vec2 greater than operator", () {
    test("should compare two vectors", () {
      final vec1 = Vec2(5, 6);
      final vec2 = Vec2(3, 4);

      expect(vec1 > vec2, true);
      expect(vec2 > vec1, false);
    });

    test("should compare negative vectors", () {
      final vec1 = Vec2(-5, -6);
      final vec2 = Vec2(-3, -4);

      expect(vec1 > vec2, false);
      expect(vec2 > vec1, true);
    });

    test("should compare zero vectors", () {
      final vec1 = Vec2(0, 0);
      final vec2 = Vec2(0, 0);

      expect(vec1 > vec2, false);
      expect(vec2 > vec1, false);
    });
  });

  group("Vec2 less than or equal operator", () {
    test("should compare two vectors", () {
      final vec1 = Vec2(1, 2);
      final vec2 = Vec2(3, 4);
      final vec3 = Vec2(1, 2);

      expect(vec1 <= vec2, true);
      expect(vec1 <= vec3, true);
      expect(vec2 <= vec1, false);
    });

    test("should compare negative vectors", () {
      final vec1 = Vec2(-1, -2);
      final vec2 = Vec2(-3, -4);
      final vec3 = Vec2(-1, -2);

      expect(vec1 <= vec2, false);
      expect(vec1 <= vec3, true);
      expect(vec2 <= vec1, true);
    });

    test("should compare zero vectors", () {
      final vec1 = Vec2(0, 0);
      final vec2 = Vec2(0, 0);

      expect(vec1 <= vec2, true);
      expect(vec2 <= vec1, true);
    });
  });

  group("Vec2 greater than or equal operator", () {
    test("should compare two vectors", () {
      final vec1 = Vec2(5, 6);
      final vec2 = Vec2(3, 4);
      final vec3 = Vec2(5, 6);

      expect(vec1 >= vec2, true);
      expect(vec1 >= vec3, true);
      expect(vec2 >= vec1, false);
    });

    test("should compare negative vectors", () {
      final vec1 = Vec2(-5, -6);
      final vec2 = Vec2(-3, -4);
      final vec3 = Vec2(-5, -6);

      expect(vec1 >= vec2, false);
      expect(vec1 >= vec3, true);
      expect(vec2 >= vec1, true);
    });

    test("should compare zero vectors", () {
      final vec1 = Vec2(0, 0);
      final vec2 = Vec2(0, 0);

      expect(vec1 >= vec2, true);
      expect(vec2 >= vec1, true);
    });
  });
}
