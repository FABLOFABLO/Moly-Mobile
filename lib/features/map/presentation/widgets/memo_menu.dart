import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moly_mobile/core/constants/assets.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MemoMenu extends StatefulWidget {
  const MemoMenu({super.key, required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<MemoMenu> createState() => _MemoMenuState();
}

class _MemoMenuState extends State<MemoMenu> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  @override
  void dispose() {
    _entry?.remove();
    super.dispose();
  }

  void _close() {
    _entry?.remove();
    _entry = null;
  }

  void _open() {
    _entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _close,
            ),
          ),
          CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            offset: const Offset(0, 6),
            child: Material(color: Colors.transparent, child: _card()),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_entry!);
  }

  Widget _card() {
    return Container(
      width: 88,
      decoration: BoxDecoration(
        color: MolyColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _row(SvgAssets.memoEdit, '수정', MolyColor.brown300, () {
            _close();
            widget.onEdit();
          }),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            color: MolyColor.gray100,
          ),
          _row(SvgAssets.memoDelete, '삭제', MolyColor.error, () {
            _close();
            widget.onDelete();
          }),
        ],
      ),
    );
  }

  Widget _row(String asset, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: MolyTextStyle.captionMedium.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _open,
        child: const Icon(Icons.more_vert, color: MolyColor.gray300),
      ),
    );
  }
}
