import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon( Iconsax.calendar,)),
    );
  }
}