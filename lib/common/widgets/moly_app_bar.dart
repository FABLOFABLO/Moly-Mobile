import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MolyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MolyAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.height = 56,
    this.down = false,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double height;
  final bool down;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (leading != null)
                down
                    ? Positioned(left: 24, top: height - 23, child: leading!)
                    : Positioned(left: 24, child: leading!),

              if (title != null)
                Center(child: Text(title!, style: MolyTextStyle.textMedium)),

              if (actions != null)
                Positioned(right: 12, child: Row(children: actions!)),
            ],
          ),
        ),
      ),
    );
  }
}
