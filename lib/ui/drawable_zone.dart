import "package:flutter/widgets.dart";
import "package:obni_draw/ui/drawable_display_zone.dart";
import "package:obni_draw/ui/drawable_type/drawable_rect_type.dart";
import "package:obni_draw/ui/drawable_type/drawable_type.dart";

class DrawableZone extends StatefulWidget {
  const DrawableZone({super.key});

  @override
  State<DrawableZone> createState() => _DrawableZoneState();
}

class _DrawableZoneState extends State<DrawableZone> {
  final List<IDrawableType> allDrawableType = [
    DrawableRectType(
        backgroundColor: const Color(0x00ffffff),
        borderColor: const Color(0xFF000000)),
    DrawableRectType(
        backgroundColor: const Color(0x2E625959),
        borderColor: const Color(0xFF7A141B)),
  ];

  late IDrawableType _currentDrawableType = allDrawableType.first;
  final DrawableDisplayZone _drawableDisplayZone = DrawableDisplayZone();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
              itemCount: allDrawableType.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                    width: 100,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentDrawableType = allDrawableType[index];
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
                    _drawableDisplayZone
                        .add(_currentDrawableType.createDrawable());
                  }
                });
              },
              onPointerMove: (event) {
                setState(() {
                  if (_currentDrawableType.onPointerMove(event)) {
                    _drawableDisplayZone
                        .add(_currentDrawableType.createDrawable());
                  }
                });
              },
              onPointerUp: (event) {
                setState(() {
                  if (_currentDrawableType.onPointerUp(event)) {
                    _drawableDisplayZone
                        .add(_currentDrawableType.createDrawable());
                  }
                });
              },
              child: Container(
                  color: const Color(0xFFEBEBEB),
                  child: Stack(
                    children: [
                      ..._drawableDisplayZone.getPositioned(),
                      _currentDrawableType.draw(),
                    ],
                  ))),
        ),
      ],
    );
  }
}
