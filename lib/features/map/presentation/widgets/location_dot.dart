import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';

class LocationDot extends StatelessWidget {
  const LocationDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MolyColor.brown100,
          border: Border.all(color: MolyColor.white, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: MolyColor.brown100.withValues(alpha: 0.45),
              blurRadius: 2,
              spreadRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
