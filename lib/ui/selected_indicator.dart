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
  final Function(RectTransform) onRectTransformUpdated;
  final Function onRectTransformModifyStart;
  final Function onRectTransformModifyEnd;

  const SelectedIndicator(
      {super.key,
      required this.drawable,
      required this.onRectTransformUpdated,
      required this.onRectTransformModifyStart,
      required this.onRectTransformModifyEnd});

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
    return [
      _buildCornerIndicator(Alignment.topLeft),
      _buildCornerIndicator(Alignment.topRight),
      _buildCornerIndicator(Alignment.bottomLeft),
      _buildCornerIndicator(Alignment.bottomRight),
    ];
  }

  Positioned _buildCornerIndicator(Alignment alignment) {
    return Positioned(
      left: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft
          ? 0
          : null,
      right:
          alignment == Alignment.topRight || alignment == Alignment.bottomRight
              ? 0
              : null,
      top: alignment == Alignment.topLeft || alignment == Alignment.topRight
          ? 0
          : null,
      bottom: alignment == Alignment.bottomLeft ||
              alignment == Alignment.bottomRight
          ? 0
          : null,
      height: _indicatorSize,
      width: _indicatorSize,
      child: GestureDetector(
        onPanStart: (_) => onRectTransformModifyStart(),
        onPanUpdate: (details) {
          RectTransform newPosition = _updatePosition(details, alignment);
          onRectTransformUpdated(newPosition);
        },
        onPanEnd: (_) => onRectTransformModifyEnd(),
        child: Container(
          height: _indicatorSize,
          width: _indicatorSize,
          decoration: BoxDecoration(
              color: _color, borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }

  RectTransform _updatePosition(
      DragUpdateDetails details, Alignment alignment) {
    RectTransform position = drawable.getPosition();
    double dx = details.delta.dx;
    double dy = details.delta.dy;

    if (alignment == Alignment.topLeft) {
      return position.copyWith(
        x: position.x + dx,
        y: position.y + dy,
        width: position.width - dx,
        height: position.height - dy,
      );
    } else if (alignment == Alignment.topRight) {
      return position.copyWith(
        y: position.y + dy,
        width: position.width + dx,
        height: position.height - dy,
      );
    } else if (alignment == Alignment.bottomLeft) {
      return position.copyWith(
        x: position.x + dx,
        width: position.width - dx,
        height: position.height + dy,
      );
    } else {
      return position.copyWith(
        width: position.width + dx,
        height: position.height + dy,
      );
    }
  }
}
