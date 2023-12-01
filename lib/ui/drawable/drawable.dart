import "package:flutter/material.dart";

abstract interface class IDrawable {
  Positioned? onPointerDown(PointerDownEvent event);

  Positioned? onPointerMove(PointerMoveEvent event);

  Positioned? onPointerUp(PointerUpEvent event);

  Positioned draw();
}