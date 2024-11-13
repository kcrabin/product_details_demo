import 'package:flutter/material.dart';

import '../../data/model/product_details_model.dart';

Widget buildVariantSelector(
    List<VariantDetail> variants,
    ValueNotifier<VariantDetail?> selectedVariant,
    ) {
  return SizedBox(
    height: 80,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: variants.length,
      itemBuilder: (context, index) {
        final variant = variants[index];
        final isSelected = selectedVariant.value == variant;
        return GestureDetector(
          onTap: () {
            selectedVariant.value = variant;
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                variant.image.isNotEmpty ? variant.image.first.path : '',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}