import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final double? height;
  final double? width;
  final Color? color;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final Function() onPressed;
  final bool isLoading;
  final double radius;

  const PrimaryButton({
    Key? key,
    required this.label,
    this.height,
    this.width,
    this.color,
    this.labelColor,
    this.labelWeight,
    required this.onPressed,
    this.isLoading = false,
    this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(radius), // Adjust the radius as needed
        ),
        backgroundColor: color ?? Theme.of(context).primaryColor,
        minimumSize: Size(width ?? double.maxFinite, height ?? 45),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      )
          : Text(label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color:
              labelColor ?? Theme.of(context).scaffoldBackgroundColor,
              fontWeight: labelWeight)),
    );
  }
}