import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HotelCardShimmer extends StatelessWidget {
  const HotelCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? const Color(0xFF1C2535) : Colors.grey[300]!;
    final highlightColor = isDark ? const Color(0xFF2A3850) : Colors.grey[100]!;
    final cardColor = isDark ? const Color(0xFF1C2535) : Colors.white;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: 280,
        height: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}