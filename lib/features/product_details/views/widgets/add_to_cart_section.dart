import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:product_details/core/views/buttons.dart';

Widget buildAddToCartSection(int? minOrder, int? maxOrder) {
  final quantity = useState<int>(1);
  // int quantity = 1;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  quantity.value = quantity.value > 1 ? quantity.value - 1 : 1;
                }),
            Text('${quantity.value}', style: const TextStyle(fontSize: 18)),
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (maxOrder != null) {
                    if (quantity.value < maxOrder) {
                      quantity.value++;
                    } else {}
                  } else {
                    quantity.value++;
                  }
                }),
          ],
        ),
      ),
      Expanded(
        child: PrimaryButton(
          onPressed: () {
            // Add to cart logic
          },
          label: 'Add to Cart',
        ),
      ),
    ],
  );
}
