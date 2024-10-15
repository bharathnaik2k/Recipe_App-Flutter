import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback pressed;
  const MyIconButton({super.key, required this.icon, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: pressed,
      icon: Icon(icon),
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(0, 0)),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
        // fixedSize: const MaterialStatePropertyAll(Size(50, 50)),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
