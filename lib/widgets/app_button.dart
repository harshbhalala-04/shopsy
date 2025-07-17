import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    this.border,
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.iconColor = Colors.black,
    this.buttonHeight,
    this.buttonWidth,
    this.fontSize,
    this.icon,
    this.borderRadius,
    this.isIconButton = false,
    this.isOutlined = false,
    this.isLoading = false,
  });

  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final Color backgroundColor;
  final BoxBorder? border;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? fontSize;
  final bool isOutlined;
  final Color borderColor;
  final IconData? icon;
  final Color? iconColor;
  final double? borderRadius;
  final bool isIconButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        style: ButtonStyle(
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.all(
            isLoading ? backgroundColor.withOpacity(0.6) : backgroundColor,
          ),
          surfaceTintColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
            side: BorderSide(
              color: isOutlined
                  ? borderColor
                  : textColor == Colors.black
                      ? Colors.transparent
                      : textColor!,
            ),
          )),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isIconButton
            ? Icon(
                icon,
                color: iconColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize ?? 16,
                    ),
                  ),
                  SizedBox(width: isLoading ? 10 : 0),
                  isLoading
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: textColor!.withOpacity(0.8),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
      ),
    );
  }
}
