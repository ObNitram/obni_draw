import "dart:math";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:obni_draw/core/drawable/drawable.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

const double _indicatorSize = 10;
const double _indicatorRay = _indicatorSize / 2;
const double _offSet = 5;
const Color _color = Color(0xff195dc2);

class SelectedIndicator extends StatefulWidget {
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
  State<SelectedIndicator> createState() => _SelectedIndicatorState();
}

class _SelectedIndicatorState extends State<SelectedIndicator> {
  @override
  Widget build(BuildContext context) {
    RectTransform position = widget.drawable.getPosition();

    return Positioned(
        left: position.a.x - _indicatorRay - _offSet,
        top: position.a.y - _indicatorRay - _offSet,
        width: max(
            position.width + _indicatorSize + _offSet * 2, _indicatorSize * 2),
        height: max(
            position.height + _indicatorSize + _offSet * 2, _indicatorSize * 2),
        child: Stack(
          children: [
            Positioned(
              left: _indicatorRay + _offSet,
              top: _indicatorRay + _offSet,
              right: _indicatorRay + _offSet,
              bottom: _indicatorRay + _offSet,
              child: widget.drawable.draw(),
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

  List<Widget> _getCornerIndicator() {
    return [
      _buildCornerIndicator(Alignment.topLeft),
      _buildCornerIndicator(Alignment.topRight),
      _buildCornerIndicator(Alignment.bottomLeft),
      _buildCornerIndicator(Alignment.bottomRight),
    ];
  }

  Alignment? currentAlignment;

  Widget _buildCornerIndicator(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onPanStart: (_) {
          widget.onRectTransformModifyStart();
          setState(() => currentAlignment = alignment);
        },
        onPanUpdate: (details) {
          RectTransform newPosition =
              _updatePosition(Vec2.fromOffset(details.delta));
          widget.onRectTransformUpdated(newPosition);
        },
        onPanEnd: (_) {
          widget.onRectTransformModifyEnd();
          setState(() => currentAlignment = null);
        },
        child: Container(
          height: _indicatorSize,
          width: _indicatorSize,
          decoration: BoxDecoration(
              color: _color, borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }

  RectTransform _updatePosition(Vec2 delta) {
    RectTransform position = widget.drawable.getPosition();

    switch (currentAlignment) {
      case Alignment.topLeft:
        final newPosition = position.copyWith(a: position.a + delta);
        if (newPosition.a >= newPosition.b) {
          setState(() => currentAlignment = Alignment.bottomRight);
        } else if (newPosition.height <= 0) {
          setState(() => currentAlignment = Alignment.bottomLeft);
        } else if (newPosition.width <= 0) {
          setState(() => currentAlignment = Alignment.topRight);
        }
        return newPosition;

      case Alignment.topRight:
        final newPosition = position.copyWith(
          a: Vec2(position.a.x, position.a.y + delta.y),
          b: Vec2(position.b.x + delta.x, position.b.y),
        );
        if (newPosition.a >= newPosition.b) {
          setState(() => currentAlignment = Alignment.bottomLeft);
        } else if (newPosition.height <= 0) {
          setState(() => currentAlignment = Alignment.bottomRight);
        } else if (newPosition.width <= 0) {
          setState(() => currentAlignment = Alignment.topLeft);
        }
        return newPosition;
      case Alignment.bottomLeft:
        final newPosition = position.copyWith(
          a: Vec2(position.a.x + delta.x, position.a.y),
          b: Vec2(position.b.x, position.b.y + delta.y),
        );

        if (newPosition.a >= newPosition.b) {
          setState(() => currentAlignment = Alignment.topRight);
        } else if (newPosition.height <= 0) {
          setState(() => currentAlignment = Alignment.topLeft);
        } else if (newPosition.width <= 0) {
          setState(() => currentAlignment = Alignment.bottomRight);
        }
        return newPosition;
      case Alignment.bottomRight:
        final newPosition = position.copyWith(b: position.b + delta);

        if (newPosition.a >= newPosition.b) {
          setState(() => currentAlignment = Alignment.topLeft);
        } else if (newPosition.height <= 0) {
          setState(() => currentAlignment = Alignment.topRight);
        } else if (newPosition.width <= 0) {
          setState(() => currentAlignment = Alignment.bottomLeft);
        }
        return newPosition;
      default:
        throw Exception("Invalid alignment");
    }
  }
}
