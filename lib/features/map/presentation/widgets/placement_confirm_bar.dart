import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';

class PlacementConfirmBar extends StatelessWidget {
  const PlacementConfirmBar({
    super.key,
    required this.hasPoint,
    required this.onConfirm,
  });

  final bool hasPoint;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: MolyButton(
          label: '메모하기',
          onPressed: hasPoint ? onConfirm : null,
        ),
      ),
    );
  }
}
