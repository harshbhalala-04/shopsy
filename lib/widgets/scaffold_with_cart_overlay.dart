import 'package:flutter/material.dart';
import 'package:shopsy/widgets/cart_overlay_widget.dart';

class BodyWithCartOverlay extends StatelessWidget {
  final Widget body;
  const BodyWithCartOverlay({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        const CartOverlayWidget(),
      ],
    );
  }
}
