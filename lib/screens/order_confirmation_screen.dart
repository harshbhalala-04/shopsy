import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopsy/constants/app_constants.dart';
import 'package:shopsy/utils/navigation_utils.dart';

import '../utils/animation_utils.dart';
import '../widgets/app_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                paymentDone,
                width: 200,
                height: 200,
                fit: BoxFit.fill,
                repeat: false,
              ),
              const Text(
                "Thank You!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Your Order is Confirmed",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Click below to continue shopping and explore more exciting finds! Keep the journey going by tapping below!",
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              AppButton(
                onPressed: () {
                  NavigationUtils.pushAndRemoveUntil(routeHomeScreen);
                },
                text: "Continue Shopping",
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
