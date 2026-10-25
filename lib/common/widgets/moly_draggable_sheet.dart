import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';

class MolyDraggableSheet extends StatefulWidget {
  const MolyDraggableSheet({
    super.key,
    required this.child,
    required this.onClose,
    this.initialSize = 0.5,
    this.minSize = 0.35,
    this.maxSize = 0.92,
  });

  final Widget child;
  final VoidCallback onClose;
  final double initialSize;
  final double minSize;
  final double maxSize;

  @override
  State<MolyDraggableSheet> createState() => _MolyDraggableSheetState();
}

class _MolyDraggableSheetState extends State<MolyDraggableSheet> {
  late double _size = widget.initialSize;
  bool _dragging = false;

  void _onDragUpdate(DragUpdateDetails d) {
    final h = MediaQuery.of(context).size.height;
    setState(() {
      _dragging = true;
      _size = (_size - d.primaryDelta! / h).clamp(0.2, widget.maxSize);
    });
  }

  void _onDragEnd(DragEndDetails d) {
    final velocity = d.primaryVelocity ?? 0;
    if (velocity > 700 || _size < widget.minSize) {
      widget.onClose();
      return;
    }
    final toInitial = (_size - widget.initialSize).abs();
    final toMax = (widget.maxSize - _size).abs();
    setState(() {
      _dragging = false;
      _size = toInitial <= toMax ? widget.initialSize : widget.maxSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final h = mq.size.height;
    final topInset = mq.viewPadding.top;
    final bottomInset = mq.viewPadding.bottom;
    final keyboard = mq.viewInsets.bottom;

    final maxHeight = h - topInset - 8 - keyboard;
    final height = (h * _size).clamp(h * 0.2, maxHeight);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboard),
        child: AnimatedContainer(
          duration: _dragging
              ? Duration.zero
              : const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: height,
          decoration: const BoxDecoration(
            color: MolyColor.hm,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: _onDragUpdate,
                onVerticalDragEnd: _onDragEnd,
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: MolyColor.gray200,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: keyboard > 0 ? 0 : bottomInset,
                  ),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
