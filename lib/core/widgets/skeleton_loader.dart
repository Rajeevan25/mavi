import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ActivitySkeletonLoader extends StatelessWidget {
  const ActivitySkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: AppColors.neutral200, width: 4),
        ),
      ),
      child: Row(
        children: [
          const SkeletonLoader(width: 40, height: 40, borderRadius: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonLoader(width: 150, height: 14),
                SizedBox(height: 6),
                SkeletonLoader(width: 100, height: 10),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const SkeletonLoader(width: 20, height: 20, borderRadius: 10),
        ],
      ),
    );
  }
}

class JobCardSkeletonLoader extends StatelessWidget {
  const JobCardSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SkeletonLoader(width: 60, height: 24, borderRadius: 12),
              SkeletonLoader(width: 40, height: 12),
            ],
          ),
          const SizedBox(height: 12),
          const SkeletonLoader(width: 200, height: 16),
          const SizedBox(height: 8),
          const SkeletonLoader(width: 140, height: 12),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Row(
            children: const [
              SkeletonLoader(width: 60, height: 14),
              SizedBox(width: 16),
              SkeletonLoader(width: 80, height: 14),
              Spacer(),
              SkeletonLoader(width: 20, height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
