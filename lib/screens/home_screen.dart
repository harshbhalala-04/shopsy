import 'package:flutter/material.dart';
import 'package:shopsy/utils/image_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(icLogo, width: 130, height: 130,),
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
