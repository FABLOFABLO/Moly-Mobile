import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moly_mobile/core/constants/assets.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MolyBottomNavBar extends StatelessWidget {
  const MolyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MolyColor.mn,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _item(index: 0, asset: SvgAssets.expedition, label: '탐험대'),
              _item(index: 1, asset: SvgAssets.map, label: '지도'),
              _item(
                index: 2,
                asset: currentIndex == 2
                    ? SvgAssets.moleSelected
                    : SvgAssets.moleUnselected,
                label: '마이페이지',
                tintable: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item({
    required int index,
    required String asset,
    required String label,
    bool tintable = true,
  }) {
    final selected = currentIndex == index;
    final color = selected ? MolyColor.brown : MolyColor.gray200;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              asset,
              width: 32,
              height: 32,
              colorFilter: tintable
                  ? ColorFilter.mode(color, BlendMode.srcIn)
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: MolyTextStyle.caption1Medium.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
