import "package:flutter/material.dart";
import "package:obni_draw/core/actions/action_type.dart";

import "package:obni_draw/states/display_zone_state.dart";

class Selector extends ActionType {
  final DisplayZoneState _displayZoneState;

  Selector({required DisplayZoneState drawableDisplayZone})
      : _displayZoneState = drawableDisplayZone;

  @override
  void onDisable() {
    _displayZoneState.deselect();
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    _displayZoneState.select(event.localPosition);
  }

  @override
  String get name => "Selector";

  @override
  IconData get icon => Icons.select_all;
}
