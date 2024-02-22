import "package:flutter/material.dart";

abstract interface class IDrawable {
  bool onPointerDown(PointerDownEvent event);

  bool onPointerMove(PointerMoveEvent event);

  bool onPointerUp(PointerUpEvent event);

  void onSelected();

  (Offset, Offset, Widget) draw();
}

class DrawableHandler implements IDrawable {
  final IDrawable drawable;

  const DrawableHandler({required this.drawable});

  @override
  (Offset, Offset, Widget) draw() {
    return drawable.draw();
  }

  @override
  void onSelected() {
    drawable.onSelected();
  }

  @override
  bool onPointerDown(PointerDownEvent event) {
    return drawable.onPointerDown(event);
  }

  @override
  bool onPointerMove(PointerMoveEvent event) {
    return drawable.onPointerMove(event);
  }

  @override
  bool onPointerUp(PointerUpEvent event) {
    return drawable.onPointerUp(event);
  }

  Widget build(BuildContext context) {
    (Offset, Offset, Widget) positioned = drawable.draw();

    return Positioned(
      left: positioned.$1.dx,
      top: positioned.$1.dy,
      width: positioned.$2.dx,
      height: positioned.$2.dy,
      child: GestureDetector(
        onTap: onSelected,
        child: positioned.$3,
      ),
    );
  }
}
