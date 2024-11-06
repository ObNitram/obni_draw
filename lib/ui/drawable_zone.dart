import "package:flutter/material.dart";
import "package:obni_draw/core/actions/draw_rect_action.dart";
import "package:obni_draw/core/actions/selector_action.dart";

import "package:obni_draw/states/display_zone_state.dart";
import "package:obni_draw/ui/actions_bar.dart";
import "package:obni_draw/states/actions_state.dart";

class DrawableZone extends StatefulWidget {
  const DrawableZone({super.key});

  @override
  State<DrawableZone> createState() => _DrawableZoneState();
}

class _DrawableZoneState extends State<DrawableZone> {
  final DisplayZoneState _displayZoneState = DisplayZoneState();
  late ActionsState _drawableTypeState;

  @override
  void initState() {
    super.initState();
    _drawableTypeState = ActionsState(
      allDrawableType: [
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
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          setState(() =>
              _drawableTypeState.currentDrawableType.onPointerDown(event));
        },
        onPointerMove: (event) {
          setState(() =>
              _drawableTypeState.currentDrawableType.onPointerMove(event));
        },
        onPointerUp: (event) {
          setState(
              () => _drawableTypeState.currentDrawableType.onPointerUp(event));
        },
        child: Container(
            color: const Color(0xFFEBEBEB),
            child: Stack(
              children: [
                ..._displayZoneState.getPositioned(),
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
