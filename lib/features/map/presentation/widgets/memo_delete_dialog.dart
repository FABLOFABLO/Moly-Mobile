import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

Future<bool> showMemoDeleteDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => const _MemoDeleteDialog(),
  );
  return result ?? false;
}

class _MemoDeleteDialog extends StatelessWidget {
  const _MemoDeleteDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MolyColor.button,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '정말 메모를 삭제하시겠습니까?',
              textAlign: TextAlign.center,
              style: MolyTextStyle.body.copyWith(color: MolyColor.gray300),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: MolyButton(
                    label: '취소',
                    backgroundColor: MolyColor.white,
                    textStyle: MolyTextStyle.buttonBold.copyWith(
                      color: MolyColor.gray300,
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MolyButton(
                    label: '확인',
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
