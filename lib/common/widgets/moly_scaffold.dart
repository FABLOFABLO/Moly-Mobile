import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_background.dart';
import 'package:moly_mobile/core/constants/color.dart';

class MolyScaffold extends StatelessWidget {
  const MolyScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.safeArea = true,
    this.backgroundVariant = MolyBackgroundVariant.one,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool safeArea;
  final MolyBackgroundVariant backgroundVariant;

  @override
  Widget build(BuildContext context) {
    final content = safeArea ? SafeArea(child: body) : body;

    return Scaffold(
      backgroundColor: MolyColor.mn,
      appBar: appBar,
      body: Stack(
        children: [
          MolyBackground(variant: backgroundVariant),
          content,
        ],
      ),
    );
  }
}
