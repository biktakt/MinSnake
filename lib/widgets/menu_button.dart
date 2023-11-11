import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Text text;
  final VoidCallback? onPressed;
  const MenuButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        child: text,
      ),
    );
  }
}
