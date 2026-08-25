import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/text_style.dart';
import 'package:moly_mobile/core/constants/color.dart';

class MolyTextField extends StatefulWidget {
  final String text;
  final String hintText;
  final bool hasIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final int minline;
  final bool big;

  const MolyTextField({
    super.key,
    required this.text,
    required this.hintText,
    required this.hasIcon,
    required this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    required this.minline,
    required this.big,
  });

  @override
  State<MolyTextField> createState() => _MolyTextFieldState();
}

class _MolyTextFieldState extends State<MolyTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: MolyTextStyle.captionMedium.copyWith(color: MolyColor.gray500)
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextField(
              style: MolyTextStyle.captionMedium.copyWith(color: MolyColor.gray500),
              minLines: widget.minline,
              maxLines: widget.minline,
              cursorHeight: 16,
              cursorColor: MolyColor.brown100,
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: widget.hasIcon && _obscureText,
              keyboardType: widget.hasIcon
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
              textInputAction: widget.textInputAction,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: MolyColor.button),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: MolyColor.button, width: 2.0),
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: MolyColor.gray200, fontSize: 14),
                filled: true,
                fillColor: MolyColor.button,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
