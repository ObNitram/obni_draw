import "package:flutter/material.dart";
import "package:obni_draw/core/actions/draw_rect_action.dart";
import "package:obni_draw/core/actions/move_action.dart";
import "package:obni_draw/core/actions/selector_action.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

import "package:obni_draw/states/display_zone_state.dart";
import "package:obni_draw/ui/actions_bar.dart";
import "package:obni_draw/states/actions_state.dart";

class DrawableZone extends StatefulWidget {
  const DrawableZone({super.key});

  @override
  State<DrawableZone> createState() => _DrawableZoneState();
}

class _DrawableZoneState extends State<DrawableZone> {
  late DisplayZoneState _displayZoneState;
  late ActionsState _drawableTypeState;

  Vec2 _position = Vec2.zero;
  final double _scale = 1;

  @override
  void initState() {
    super.initState();
    _displayZoneState =
        DisplayZoneState(notifyListeners: () => setState(() {}));

    _drawableTypeState = ActionsState(
      allDrawableType: [
        MoveAction(
            onMove: (delta) => setState(() {
                  _position += delta;
                })),
        Selector(drawableDisplayZone: _displayZoneState),
        DrawableRectAction(
            displayZoneState: _displayZoneState,
            backgroundColor: const Color(0x00ffffff),
            borderColor: const Color(0xFF000000),
            radius: 0,
            iconData: Icons.rectangle_outlined,
            name: "Rectangle"),
        DrawableRectAction(
            displayZoneState: _displayZoneState,
            backgroundColor: const Color(0x2E625959),
            borderColor: const Color(0xFF7A141B),
            radius: 20,
            iconData: Icons.rectangle_rounded,
            name: "Rectangle Rounded"),
      ],
      onChanged: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: (event) {
          _drawableTypeState.currentDrawableType
              .onPointerDown(event, _position);
          setState(() => {});
        },
        onPanUpdate: (event) {
          _drawableTypeState.currentDrawableType
              .onPointerMove(event, _position);
          setState(() => {});
        },
        onPanEnd: (event) {
          _drawableTypeState.currentDrawableType.onPointerUp(event, _position);
          setState(() => {});
        },
        child: Container(
            color: const Color(0xFFFFFFFF),
            child: Stack(
              children: [
                ..._displayZoneState.getPositioned(_scale, _position),
                _drawableTypeState.currentDrawableType.draw(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ActionsBar(drawableTypeState: _drawableTypeState),
                  ),
                )
              ],
            )));
  }
}
