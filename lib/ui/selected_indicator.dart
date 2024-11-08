import "dart:math";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:obni_draw/core/drawable/drawable.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

const double _indicatorSize = 10;
const double _indicatorRay = _indicatorSize / 2;
const double _indicatorPadding = 5;
const Color _color = Color(0xff195dc2);

class SelectedIndicator extends StatefulWidget {
  final IDrawable drawable;
  final Vec2 offset;
  final Function(RectTransform) onRectTransformUpdated;

  const SelectedIndicator({
    super.key,
    required this.drawable,
    required this.offset,
    required this.onRectTransformUpdated,
  });

  @override
  State<SelectedIndicator> createState() => _SelectedIndicatorState();
}

class _SelectedIndicatorState extends State<SelectedIndicator> {
  @override
  Widget build(BuildContext context) {
    RectTransform position = widget.drawable.getPosition();

    return Positioned(
        left: position.topLeft.x -
            _indicatorRay -
            _indicatorPadding +
            widget.offset.x,
        top: position.topLeft.y -
            _indicatorRay -
            _indicatorPadding +
            widget.offset.y,
        width: max(position.width + _indicatorSize + _indicatorPadding * 2,
            _indicatorSize * 2),
        height: max(position.height + _indicatorSize + _indicatorPadding * 2,
            _indicatorSize * 2),
        child: Stack(
          children: [
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
          setState(() => currentAlignment = alignment);
        },
        onPanUpdate: (details) {
          RectTransform newPosition =
              _updatePosition(Vec2.fromOffset(details.delta));
          widget.onRectTransformUpdated(newPosition);
        },
        onPanEnd: (_) {
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
        final newPosition = position.copyWith(
            ax: position.topLeft.x + delta.x, ay: position.topLeft.y + delta.y);

        if (newPosition.topLeft >= newPosition.bottomRight) {
          setState(() => currentAlignment = Alignment.bottomRight);
        } else if (newPosition.height <= 0) {
          setState(() => currentAlignment = Alignment.bottomLeft);
        } else if (newPosition.width <= 0) {
          setState(() => currentAlignment = Alignment.topRight);
        }

        return newPosition;

      case Alignment.topRight:
        final newPosition = position.copyWith(
            ay: position.topLeft.y + delta.y,
            bx: position.bottomRight.x + delta.x);

        if (newPosition.topLeft >= newPosition.bottomRight) {
          setState(() => currentAlignment = Alignment.bottomLeft);
        } else if (newPosition.height <= 0) {
          setState(() => currentAlignment = Alignment.bottomRight);
        } else if (newPosition.width <= 0) {
          setState(() => currentAlignment = Alignment.topLeft);
        }

        return newPosition;

      case Alignment.bottomLeft:
        final newPosition = position.copyWith(
            ax: position.topLeft.x + delta.x,
            by: position.bottomRight.y + delta.y);

        if (newPosition.topLeft >= newPosition.bottomRight) {
          setState(() => currentAlignment = Alignment.topRight);
        } else if (newPosition.height <= 0) {
          setState(() => currentAlignment = Alignment.topLeft);
        } else if (newPosition.width <= 0) {
          setState(() => currentAlignment = Alignment.bottomRight);
        }

        return newPosition;

      case Alignment.bottomRight:
        final newPosition = position.copyWith(
            bx: position.bottomRight.x + delta.x,
            by: position.bottomRight.y + delta.y);

        if (newPosition.topLeft >= newPosition.bottomRight) {
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
