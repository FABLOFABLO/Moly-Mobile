import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MolyButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final double height;
  final bool hasBorder;
  final Widget? icon;

  const MolyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor = MolyColor.brown,
    this.height = 56,
    this.hasBorder = false,
    this.icon,
  });

  bool get _enabled => onPressed != null;

  @override
  State<MolyButton> createState() => _MolyButtonState();
}

class _MolyButtonState extends State<MolyButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget._enabled) {
      setState(() => _pressed = value);
    }
  }

  Color get _backgroundColor {
    if (!widget._enabled) return MolyColor.button;
    if (_pressed) {
      return Color.lerp(widget.backgroundColor, Colors.black, 0.15)!;
    }
    return widget.backgroundColor;
  }

  TextStyle get _textStyle {
    final base =
        widget.textStyle ??
        MolyTextStyle.textBold.copyWith(color: MolyColor.white);
    if (!widget._enabled) return base.copyWith(color: MolyColor.gray200);
    return base;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(40),
          border: widget.hasBorder
              ? Border.all(color: MolyColor.brown, width: 1)
              : null,
        ),
        child: widget.icon == null
            ? Text(widget.label, style: _textStyle)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon!,
                  const SizedBox(width: 8),
                  Text(widget.label, style: _textStyle),
                ],
              ),
      ),
    );
  }
}
