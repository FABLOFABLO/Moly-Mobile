import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';

class MyLocationButton extends StatelessWidget {
  const MyLocationButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: MolyColor.hm,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: MolyColor.black.withValues(alpha: 0.12),
              blurRadius: 8,
            ),
          ],
        ),
        child: const Icon(
          Icons.location_searching,
          color: MolyColor.brown100,
          size: 26,
        ),
      ),
    );
  }
}
