import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MemoWriteSheet extends StatefulWidget {
  const MemoWriteSheet({super.key, required this.onSubmit});

  final ValueChanged<String> onSubmit;

  @override
  State<MemoWriteSheet> createState() => _MemoWriteSheetState();
}

class _MemoWriteSheetState extends State<MemoWriteSheet> {
  final TextEditingController _controller = TextEditingController();

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
                Text(
                  '새 메모',
                  style: MolyTextStyle.headline3.copyWith(
                    color: MolyColor.black,
                  ),
                ),
                const SizedBox(height: 22),
                TextField(
                  controller: _controller,
                  maxLines: null,
                  minLines: 8,
                  maxLength: 300,
                  style: MolyTextStyle.buttonMedium,
                  decoration: InputDecoration(
                    counterText: '',
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: '지금 이 순간을 기록해보세요!',
                    hintStyle: MolyTextStyle.buttonMedium.copyWith(
                      color: MolyColor.gray200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_controller.text.characters.length}/300',
                  style: MolyTextStyle.buttonMedium.copyWith(
                    color: MolyColor.gray300,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MolyButton(
                label: '작성',
                onPressed: _controller.text.trim().isEmpty
                    ? null
                    : () => widget.onSubmit(_controller.text.trim()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
