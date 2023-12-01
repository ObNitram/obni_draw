import "package:flutter/widgets.dart";
import "package:obni_draw/ui/drawable/drawable.dart";
import "package:obni_draw/ui/drawable/drawable_circle.dart";
import "package:obni_draw/ui/drawable/drawable_rect.dart";

class DrawableZone extends StatefulWidget {
  const DrawableZone({super.key});

  @override
  State<DrawableZone> createState() => _DrawableZoneState();
}

class _DrawableZoneState extends State<DrawableZone> {
  final List<IDrawable> _allDrawable = [DrawableRect(), DrawableCircle()];
  late IDrawable _drawable;

  final List<Positioned> _allPositioned = [];

  @override
  Widget build(BuildContext context) {
    _drawable = _allDrawable.first;

    return Listener(
        onPointerDown: (event) {
          setState(() {
            Positioned? positioned = _drawable.onPointerDown(event);
            if (positioned != null) {
              _allPositioned.add(positioned);
            }
          });
        },
        onPointerMove: (event) {
          setState(() {
            Positioned? positioned = _drawable.onPointerMove(event);
            if (positioned != null) {
              _allPositioned.add(positioned);
            }
          });
        },
        onPointerUp: (event) {
          setState(() {
            Positioned? positioned = _drawable.onPointerUp(event);
            if (positioned != null) {
              _allPositioned.add(positioned);
            }
          });
        },
        child: Container(
            color: const Color(0xFFEBEBEB),
            child: Stack(
              children: [
                ..._allPositioned,
                _drawable.draw(),
              ],
            )));
  }
}
