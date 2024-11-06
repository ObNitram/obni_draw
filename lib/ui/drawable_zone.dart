import "package:flutter/widgets.dart";
import "package:obni_draw/ui/drawable_display_zone.dart";
import "package:obni_draw/ui/drawable_type/drawable_rect_type.dart";
import "package:obni_draw/ui/drawable_type/drawable_type.dart";
import "package:obni_draw/ui/drawable_type/selector.dart";

class DrawableZone extends StatefulWidget {
  DrawableZone({super.key}) {
    allDrawableType = [
      Selector(drawableDisplayZone: _drawableDisplayZone),
      DrawableRectType(
          backgroundColor: const Color(0x00ffffff),
          borderColor: const Color(0xFF000000)),
      DrawableRectType(
          backgroundColor: const Color(0x2E625959),
          borderColor: const Color(0xFF7A141B)),
    ];
  }

  final DrawableDisplayZone _drawableDisplayZone = DrawableDisplayZone();
  late List<IDrawableType> allDrawableType;

  @override
  State<DrawableZone> createState() => _DrawableZoneState();
}

class _DrawableZoneState extends State<DrawableZone> {
  late IDrawableType _currentDrawableType;

  @override
  void initState() {
    super.initState();
    _currentDrawableType = widget.allDrawableType.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
              itemCount: widget.allDrawableType.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                    width: 100,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentDrawableType = widget.allDrawableType[index];
                        });
                      },
                      child: Text("Drawable  $index"),
                    ));
              }),
        ),
        Expanded(
          flex: 8,
          child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) {
                setState(() {
                  if (_currentDrawableType.onPointerDown(event)) {
                    widget._drawableDisplayZone
                        .add(_currentDrawableType.createDrawable());
                  }
                });
              },
              onPointerMove: (event) {
                setState(() {
                  if (_currentDrawableType.onPointerMove(event)) {
                    widget._drawableDisplayZone
                        .add(_currentDrawableType.createDrawable());
                  }
                });
              },
              onPointerUp: (event) {
                setState(() {
                  if (_currentDrawableType.onPointerUp(event)) {
                    widget._drawableDisplayZone
                        .add(_currentDrawableType.createDrawable());
                  }
                });
              },
              child: Container(
                  color: const Color(0xFFEBEBEB),
                  child: Stack(
                    children: [
                      ...widget._drawableDisplayZone.getPositioned(),
                      _currentDrawableType.draw(),
                    ],
                  ))),
        ),
      ],
    );
  }
}
