import "package:obni_draw/core/actions/action_type.dart";

class ActionsState {
  final List<ActionType> allDrawableType;
  final Function onChanged;
  late ActionType currentDrawableType;

  ActionsState({required this.allDrawableType, required this.onChanged})
      : currentDrawableType = allDrawableType.first;

  void changeDrawableType(int index) {
    currentDrawableType.onDisable();
    currentDrawableType = allDrawableType[index];
    currentDrawableType.onEnable();
    onChanged();
  }
}
