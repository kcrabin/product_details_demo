import 'package:flutter/material.dart';

import '../../data/model/product_details_model.dart';

Widget buildProductInfo(VariantDetail product, String productName) {
  double discountPercentage = ((product.strikePrice - product.price) / product.strikePrice) * 100;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        productName,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Text('\$${product.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
          const SizedBox(width: 10),
          Text('\$${product.strikePrice}', style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 16)),
          const SizedBox(width: 10),
          Text('${discountPercentage.toStringAsFixed(1)}% off', style: const TextStyle(color: Colors.green)),
        ],
      ),
      const SizedBox(height: 8),
      Text('Available Stock: ${product.stock ?? 'N/A'}', style: const TextStyle(color: Colors.grey)),
    ],
  );
}
