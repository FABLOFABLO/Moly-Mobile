import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MapFab extends StatefulWidget {
  const MapFab({super.key, this.onTimeCapsule, this.onMemo});

  final VoidCallback? onTimeCapsule;
  final VoidCallback? onMemo;

  @override
  State<MapFab> createState() => _MapFabState();
}

class _MapFabState extends State<MapFab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 130),
  );
  bool _open = false;

  void _toggle() {
    setState(() => _open = !_open);
    _open ? _controller.forward() : _controller.reverse();
  }

  void _run(VoidCallback? action) {
    _toggle();
    action?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_open)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              child: ColoredBox(
                color: MolyColor.black.withValues(alpha: 0.3),
              ),
            ),
          ),
        Positioned(
          right: 20,
          bottom: 40,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [_menu(), const SizedBox(height: 16), _fab()],
          ),
        ),
      ],
    );
  }

  Widget _menu() {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      alignment: Alignment.bottomCenter,
      child: FadeTransition(
        opacity: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _action('타임캡슐 만들기', () => _run(widget.onTimeCapsule)),
            const SizedBox(height: 12),
            _action('메모 만들기', () => _run(widget.onMemo)),
          ],
        ),
      ),
    );
  }

  Widget _action(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: MolyColor.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: MolyColor.black.withValues(alpha: 0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Text(
          label,
          style: MolyTextStyle.captionMedium.copyWith(color: MolyColor.gray300),
        ),
      ),
    );
  }

  Widget _fab() {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: MolyColor.brown100,
          shape: BoxShape.circle,
        ),
        child: RotationTransition(
          turns: Tween<double>(begin: 0, end: 0.125).animate(_controller),
          child: const Icon(Icons.add, color: MolyColor.white, size: 32),
        ),
      ),
    );
  }
}
