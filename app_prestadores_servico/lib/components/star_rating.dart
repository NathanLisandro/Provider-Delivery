import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final Function(double rating)? onRatingChanged;
  final Color color;

  const StarRating({this.rating = 0.0, this.onRatingChanged, this.color = Colors.amber});

  Widget buildStar(BuildContext context, int index) {
    IconData iconData;
    double starValue = index + 1.0;

    if (rating >= starValue) {
      iconData = Icons.star;
    } else if (rating >= starValue - 0.5) {
      iconData = Icons.star_half;
    } else {
      iconData = Icons.star_border;
    }

    return IconButton(
      onPressed: onRatingChanged != null ? () => onRatingChanged!(starValue) : null,
      icon: Icon(
        iconData,
        color: color,
      ),
      iconSize: 24.0,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) => buildStar(context, index)),
    );
  }
}
