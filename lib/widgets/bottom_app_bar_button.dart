import 'package:flutter/material.dart';

class BottomAppBarButton extends StatelessWidget {
  final Text text;
  final VoidCallback? onPressed;
  const BottomAppBarButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onPressed,
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}
