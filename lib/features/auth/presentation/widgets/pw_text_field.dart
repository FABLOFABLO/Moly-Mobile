import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class PwTextField extends StatefulWidget {
  final String text;
  final String hintText;
  final bool hasIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool hasError;
  final int minline;

  const PwTextField({
    super.key,
    required this.text,
    required this.hintText,
    required this.hasIcon,
    required this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.hasError = false,
    required this.minline,
  });

  @override
  State<PwTextField> createState() => _PwTextFieldState();
}

class _PwTextFieldState extends State<PwTextField> {
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
            style: MolyTextStyle.captionMedium.copyWith(
              color: MolyColor.gray500,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextField(
              obscuringCharacter: '●',
              style: MolyTextStyle.captionMedium.copyWith(
                color: MolyColor.gray500,
              ),
              minLines: widget.minline,
              maxLines: widget.minline,
              cursorColor: MolyColor.brown100,
              cursorHeight: 16,
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: widget.hasIcon && _obscureText,
              keyboardType: TextInputType.text,
              textInputAction: widget.textInputAction,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: MolyColor.gray200, fontSize: 14),
                filled: true,
                fillColor: MolyColor.button,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: widget.hasError ? BorderSide(color: MolyColor.error) : BorderSide(color: MolyColor.button),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: widget.hasError ? BorderSide(color: MolyColor.error) : BorderSide(color: MolyColor.button),
                ),
                suffixIcon: widget.hasIcon
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: MolyColor.brown100,
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                ),
              ),
            ),
          ),
          widget.hasError
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.error, color: MolyColor.error, size: 13),
                      const SizedBox(width: 2),
                      Text(
                        '비밀번호가 일치하지 않습니다.',
                        style: MolyTextStyle.caption1Medium.copyWith(
                          color: MolyColor.error,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
