import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Carousel Placeholder
            Container(
              height: 300,
              color: Colors.white,
            ),
            const SizedBox(height: 16),

            // Variant Selector Placeholder
            Row(
              children: List.generate(4, (index) => _buildShimmerBox(width: 60, height: 60)),
            ),
            const SizedBox(height: 16),

            // Product Info Placeholder
            _buildShimmerBox(width: 200, height: 24),
            const SizedBox(height: 8),
            _buildShimmerBox(width: 120, height: 16),
            const SizedBox(height: 16),

            // Price and Stock Placeholder
            Row(
              children: [
                _buildShimmerBox(width: 80, height: 24),
                const SizedBox(width: 8),
                _buildShimmerBox(width: 60, height: 16),
                const SizedBox(width: 8),
                _buildShimmerBox(width: 60, height: 16),
              ],
            ),
            const SizedBox(height: 8),
            _buildShimmerBox(width: 140, height: 16),
            const SizedBox(height: 16),

            // Review Section Placeholder
            _buildShimmerBox(width: double.infinity, height: 50),
            const SizedBox(height: 16),

            // Add to Cart Section Placeholder
            _buildShimmerBox(width: double.infinity, height: 50),
            const SizedBox(height: 16),

            // Description & Specifications Placeholder
            _buildShimmerBox(width: 120, height: 24),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(3, (_) => _buildShimmerBox(width: double.infinity, height: 16, padding: const EdgeInsets.only(bottom: 8))),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a shimmering box with specified dimensions
  Widget _buildShimmerBox({double width = double.infinity, double height = 16.0, EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
