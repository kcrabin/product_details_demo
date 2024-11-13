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

class PrimaryTextButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final double? height;
  final Function() onPressed;
  final bool isSmallButton;

  const PrimaryTextButton({
    Key? key,
    required this.label,
    this.height,
    required this.onPressed,
    this.labelColor,
    this.isSmallButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        label,
        style: isSmallButton
            ? Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: labelColor ?? Theme.of(context).primaryColor)
            : Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: labelColor ?? Theme.of(context).primaryColor),
      ),
    );
  }
}

class PrimaryOutlinedButton extends StatelessWidget {
  double? width;
  double? height;
  Color? borderColor;
  Function onPressed;
  double? radius;
  Widget? loadingWidget;
  String title;
  Color? titleColor;
  Widget? icon;
  Color? iconColor;
  double? iconSize;

  PrimaryOutlinedButton(
      {Key? key,
        this.radius,
        this.width,
        this.iconSize,
        this.borderColor,
        this.loadingWidget,
        this.icon,
        this.iconColor,
        this.height,
        this.titleColor,
        required this.onPressed,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: borderColor ?? Theme.of(context).primaryColor,
        elevation: 0,
        minimumSize: Size(width ?? double.infinity, height ?? 40.0),
        side: BorderSide(
          width: 1,
          color: borderColor ?? Theme.of(context).primaryColor,
          style: BorderStyle.solid,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: loadingWidget ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SizedBox(
                    width: iconSize ?? 15,
                    child: icon,
                  ),
                ),
              Text(title,
                  style: TextStyle(
                      color: borderColor ?? Theme.of(context).primaryColor)),
            ],
          ),
    );
  }
}
