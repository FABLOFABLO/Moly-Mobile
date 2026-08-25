import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moly_mobile/core/constants/assets.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MolyAppBar extends StatelessWidget {
  final String label;

  const MolyAppBar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 150,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(SvgAssets.back)),
                const SizedBox(height: 24),
                Text(label, style: MolyTextStyle.headline3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
