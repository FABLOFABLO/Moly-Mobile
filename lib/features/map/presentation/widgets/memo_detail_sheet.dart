import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';
import 'package:moly_mobile/features/map/presentation/widgets/memo_menu.dart';

class MemoDetailSheet extends StatefulWidget {
  const MemoDetailSheet({
    super.key,
    required this.text,
    required this.createdAt,
    required this.onSave,
    required this.onDelete,
  });

  final String text;
  final DateTime createdAt;
  final ValueChanged<String> onSave;
  final VoidCallback onDelete;

  @override
  State<MemoDetailSheet> createState() => _MemoDetailSheetState();
}

class _MemoDetailSheetState extends State<MemoDetailSheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.text,
  );
  late String _text = widget.text;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _dateLabel {
    final d = widget.createdAt;
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '${d.year}.$mm.$dd';
  }

  void _save() {
    final text = _controller.text.trim();
    widget.onSave(text);
    setState(() {
      _text = text;
      _editing = false;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(24, 6, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '메모',
                        style: MolyTextStyle.headline3.copyWith(
                          color: MolyColor.black,
                        ),
                      ),
                      if (!_editing)
                        MemoMenu(
                          onEdit: () => setState(() => _editing = true),
                          onDelete: widget.onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _editing
                    ? TextField(
                        controller: _controller,
                        maxLines: null,
                        minLines: 8,
                        maxLength: 300,
                        style: MolyTextStyle.textMedium,
                        decoration: const InputDecoration(
                          counterText: '',
                          isCollapsed: true,
                          border: InputBorder.none,
                        ),
                      )
                    : Text(_text, style: MolyTextStyle.textMedium),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: _editing
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_controller.text.characters.length}/300',
                        style: MolyTextStyle.buttonMedium.copyWith(
                          color: MolyColor.gray200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MolyButton(
                      label: '저장',
                      onPressed: _controller.text.trim().isEmpty ? null : _save,
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _dateLabel,
                    style: MolyTextStyle.captionMedium.copyWith(
                      color: MolyColor.gray300,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
