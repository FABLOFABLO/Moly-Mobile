import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

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
  final bool hasError;
  final String errorText;

  const MolyTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.hasIcon = false,
    required this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    required this.minline,
    this.big = false,
    this.hasError = false,
    this.errorText = '비밀번호가 일치하지 않습니다.',
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
                  borderSide: BorderSide(
                    color: widget.hasError ? MolyColor.error : MolyColor.button,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: widget.hasError ? MolyColor.error : MolyColor.button,
                    width: 2,
                  ),
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: MolyColor.gray200, fontSize: 14),
                filled: true,
                fillColor: MolyColor.button,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                suffixIcon: widget.hasIcon
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: MolyColor.brown100,
                          ),
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
          if (widget.hasError)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.error, color: MolyColor.error, size: 13),
                  const SizedBox(width: 2),
                  Text(
                    widget.errorText,
                    style: MolyTextStyle.caption1Medium.copyWith(
                      color: MolyColor.error,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(height: 10),
        ],
      ),
    );
  }
}
