import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class ExpeditionPage extends StatelessWidget {
  const ExpeditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MolyScaffold(
      body: Center(child: Text('탐험대', style: MolyTextStyle.headline2)),
    );
  }
}
