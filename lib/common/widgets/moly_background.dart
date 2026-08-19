import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';

enum MolyBackgroundVariant { one, two }

class MolyBackground extends StatelessWidget {
  const MolyBackground({super.key, this.variant = MolyBackgroundVariant.one});

  final MolyBackgroundVariant variant;

  static const List<_Circle> _circlesOne = [
    _Circle(left: -20, top: 70, size: 90, color: MolyColor.yellow),
    _Circle(right: -40, top: 90, size: 130, color: MolyColor.blue),
    _Circle(right: 25, top: 230, size: 45, color: MolyColor.pink),
    _Circle(right: 20, top: 400, size: 30, color: MolyColor.yellow),
    _Circle(left: -35, top: 450, size: 100, color: MolyColor.blue),
    _Circle(left: 40, top: 550, size: 50, color: MolyColor.pink),
    _Circle(right: 20, top: 530, size: 90, color: MolyColor.yellow),
  ];

  static const List<_Circle> _circlesTwo = [
    _Circle(left: -20, top: 70, size: 65, color: MolyColor.yellow),
    _Circle(right: -30, top: 70, size: 130, color: MolyColor.yellow),
    _Circle(right: 60, top: 220, size: 45, color: MolyColor.pink),
    _Circle(left: 20, top: 500, size: 55, color: MolyColor.yellow),
    _Circle(right: -50, top: 450, size: 120, color: MolyColor.pink),
    _Circle(right: 10, top: 580, size: 40, color: MolyColor.blue),
    _Circle(left: -30, top: 570, size: 130, color: MolyColor.blue),
  ];

  List<_Circle> get _circles =>
      variant == MolyBackgroundVariant.one ? _circlesOne : _circlesTwo;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: MolyColor.mn,
        child: Stack(children: [for (final c in _circles) c.build()]),
      ),
    );
  }
}

class _Circle {
  const _Circle({
    this.left,
    this.right,
    required this.top,
    required this.size,
    required this.color,
  });

  final double? left;
  final double? right;
  final double top;
  final double size;
  final Color color;

  Widget build() {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
