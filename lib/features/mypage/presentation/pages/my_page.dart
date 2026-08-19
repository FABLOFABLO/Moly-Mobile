import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MolyScaffold(
      body: Center(child: Text('마이페이지', style: MolyTextStyle.headline2)),
    );
  }
}
