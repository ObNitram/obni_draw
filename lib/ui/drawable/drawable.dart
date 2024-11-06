import "package:flutter/material.dart";
import "package:obni_draw/core/transform.dart";

abstract interface class IDrawable {
  Widget draw();

  RectTransform getPosition();
}
