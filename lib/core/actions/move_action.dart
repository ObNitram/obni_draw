import "package:flutter/cupertino.dart";
import "package:obni_draw/core/actions/action_type.dart";
import "package:obni_draw/core/utils/rect_transform.dart";

class MoveAction extends ActionType {
  final Function(Vec2 delta) onMove;

  MoveAction({required this.onMove});

  @override
  void onPointerMove(DragUpdateDetails event, offset) {
    onMove(Vec2.fromOffset(event.delta));
  }

  @override
  IconData get icon => CupertinoIcons.move;

  @override
  String get name => "Move";
}
