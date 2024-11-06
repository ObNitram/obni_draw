import "package:flutter/material.dart";

import "package:obni_draw/states/actions_state.dart";

class ActionsBar extends StatefulWidget {
  const ActionsBar({super.key, required this.drawableTypeState});

  final ActionsState drawableTypeState;

  @override
  State<ActionsBar> createState() => _ActionsBarState();
}

class _ActionsBarState extends State<ActionsBar> {
  static const double caseSize = 60;
  static const double margin = 5;

  @override
  Widget build(BuildContext context) {
    var allDrawableType = widget.drawableTypeState.allDrawableType;

    return Container(
      height: caseSize + margin * 2,
      width: (caseSize + margin) * allDrawableType.length + margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x38000000)),
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: allDrawableType.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(margin / 2),
        itemBuilder: (context, index) {
          var drawableType = allDrawableType[index];

          return GestureDetector(
            onTap: () => changeDrawableType(index),
            child: Container(
              margin: const EdgeInsets.all(margin / 2),
              width: caseSize,
              height: caseSize,
              decoration: BoxDecoration(
                color:
                    drawableType == widget.drawableTypeState.currentDrawableType
                        ? Color(0xFFe0dfff)
                        : Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(drawableType.icon),
            ),
          );
        },
      ),
    );
  }

  void changeDrawableType(int index) {
    setState(() => widget.drawableTypeState.changeDrawableType(index));
  }
}
