import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moly_mobile/core/constants/assets.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MolyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MolyAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.height = 56,
    this.hasDown = false,
    this.hasBack = false,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double height;
  final bool hasDown;
  final bool hasBack;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final Widget? leadingWidget =
    hasBack ? _buildBackButton(context) : leading;

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (leadingWidget != null)
                Positioned(
                  left: 24,
                  top: hasDown ? height - 23 : null,
                  child: leadingWidget,
                ),

              if (title != null)
                Center(
                  child: Text(
                    title!,
                    style: MolyTextStyle.textMedium,
                  ),
                ),

              if (actions != null)
                Positioned(
                  right: 12,
                  child: Row(
                    children: actions!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: SvgPicture.asset(SvgAssets.back),
    );
  }
}