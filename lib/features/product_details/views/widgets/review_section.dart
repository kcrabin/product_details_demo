import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget buildReviewSection(double averageRating) {
  return RatingBar.builder(
    initialRating: averageRating,
    minRating: 1,
    direction:  Axis.horizontal,
    allowHalfRating: true,
    unratedColor: Colors.amber.withAlpha(50),
    itemCount: 5,
    itemSize: 25.0,
    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    ignoreGestures: true,
    onRatingUpdate: (rating) {

    },
  );
}
