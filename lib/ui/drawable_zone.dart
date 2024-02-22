import "package:flutter/widgets.dart";
import "package:log_tanker/log_tanker.dart";
import "package:obni_draw/ui/drawable/drawable.dart";
import "package:obni_draw/ui/drawable/drawable_rect.dart";
import "package:obni_draw/ui/drawable/drawable_type.dart";

Logger _logger = Logger(loggerName: "DrawableZone");

class DrawableZone extends StatefulWidget {
  const DrawableZone({super.key});

  @override
  State<DrawableZone> createState() => _DrawableZoneState();
}

class _DrawableZoneState extends State<DrawableZone> {
  final List<IDrawableType> allDrawableType = [
    DrawableRectType(),
    DrawableRectType(color: const Color(0xFF00FF00)),
  ];
  late IDrawableType _currentDrawableType = allDrawableType.first;

  late DrawableHandler _currentDrawable =
      DrawableHandler(drawable: _currentDrawableType.createDrawable());
  final List<DrawableHandler> _allPositionedDrawable = [];

  @override
  Widget build(BuildContext context) {
    _logger.v("Total positioned: ${_allPositionedDrawable.length}");

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
                          _currentDrawable = DrawableHandler(
                              drawable: _currentDrawableType.createDrawable());
                        });
                      },
                      child: Text("Drawable $index"),
                    ));
              }),
        ),
        Expanded(
          flex: 8,
          child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) {
                setState(() {
                  if (_currentDrawable.onPointerDown(event)) {
                    _logger.v("onPointerDown");
                    _allPositionedDrawable.add(_currentDrawable);
                    _currentDrawable = DrawableHandler(
                        drawable: _currentDrawableType.createDrawable());
                  }
                });
              },
              onPointerMove: (event) {
                setState(() {
                  if (_currentDrawable.onPointerMove(event)) {
                    _logger.v("onPointerMove");
                    _allPositionedDrawable.add(_currentDrawable);
                    _currentDrawable = DrawableHandler(
                        drawable: _currentDrawableType.createDrawable());
                  }
                });
              },
              onPointerUp: (event) {
                setState(() {
                  if (_currentDrawable.onPointerUp(event)) {
                    _logger.v("onPointerUp");
                    _allPositionedDrawable.add(_currentDrawable);
                    _currentDrawable = DrawableHandler(
                        drawable: _currentDrawableType.createDrawable());
                  }
                });
              },
              child: Container(
                  color: const Color(0xFFEBEBEB),
                  child: Stack(
                    children: [
                      ..._allPositionedDrawable.map((e) => e.build(context)),
                      _currentDrawable.build(context),
                    ],
                  ))),
        ),
      ],
    );
  }
}
