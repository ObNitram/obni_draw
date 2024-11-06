import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:obni_draw/core/drawable/drawable.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

const double _indicatorSize = 10;
const double _indicatorRay = _indicatorSize / 2;
const double _offSet = 5;
const Color _color = Color(0xff195dc2);

class SelectedIndicator extends StatelessWidget {
  final IDrawable drawable;

  const SelectedIndicator({super.key, required this.drawable});

  @override
  Widget build(BuildContext context) {
    RectTransform position = drawable.getPosition();

    return Positioned(
        left: position.x - _indicatorRay - _offSet,
        top: position.y - _indicatorRay - _offSet,
        width: position.width + _indicatorSize + _offSet * 2,
        height: position.height + _indicatorSize + _offSet * 2,
        child: Stack(
          children: [
            Positioned(
              left: _indicatorRay + _offSet,
              top: _indicatorRay + _offSet,
              right: _indicatorRay + _offSet,
              bottom: _indicatorRay + _offSet,
              child: drawable.draw(),
            ),
            _getBorderIndicator(),
            ..._getCornerIndicator(),
          ],
        ));
  }

  Positioned _getBorderIndicator() {
    return Positioned(
      left: _indicatorRay,
      top: _indicatorRay,
      right: _indicatorRay,
      bottom: _indicatorRay,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: _color)),
      ),
    );
  }

  List<Positioned> _getCornerIndicator() {
    final indicator = Container(
      height: _indicatorSize,
      width: _indicatorSize,
      decoration:
          BoxDecoration(color: _color, borderRadius: BorderRadius.circular(3)),
    );

    return [
      Positioned(
          left: 0,
          top: 0,
          height: _indicatorSize,
          width: _indicatorSize,
          child: indicator),
      Positioned(
          right: 0,
          top: 0,
          height: _indicatorSize,
          width: _indicatorSize,
          child: indicator),
      Positioned(
          left: 0,
          bottom: 0,
          height: _indicatorSize,
          width: _indicatorSize,
          child: indicator),
      Positioned(
          right: 0,
          bottom: 0,
          height: _indicatorSize,
          width: _indicatorSize,
          child: indicator),
    ];
  }
}
