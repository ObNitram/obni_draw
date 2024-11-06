import "package:flutter/material.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

abstract interface class IDrawable {
  Widget draw();

  RectTransform getPosition();

  void setPosition(RectTransform rectTransform);
}
