import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MolyScaffold(
      body: Center(child: Text('지도', style: MolyTextStyle.headline2)),
    );
  }
}
