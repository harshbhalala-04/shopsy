import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration(
    {Color? color, double? radius, Color? borderColor, double? borderWidth}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(radius ?? 5),
    ),
    border: Border.all(
      color: borderColor ?? Colors.transparent,
      width: borderWidth ?? 0,
    ),
  );
}
