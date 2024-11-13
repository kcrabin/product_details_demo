import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../data/model/product_details_model.dart';

Widget buildProductImageCarousel(List<ImageModel> images) {
  return Column(
    children: [
      CarouselSlider(
        options: CarouselOptions(
          height: 300,
          enlargeCenterPage: true,
          autoPlay: false,
        ),
        items: images.map((image) {
          return Image.network(image.path, fit: BoxFit.cover);
        }).toList(),
      ),
      // Thumbnails below the carousel
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((image) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Image.network(
                image.path,
                width: 60,
                height: 60,
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}
