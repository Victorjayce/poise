import 'package:flutter/material.dart';

class BackToTopButton extends StatelessWidget {
  final bool visible;
  final ScrollController controller;

  const BackToTopButton({
    super.key,
    required this.visible,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: AnimatedScale(
        scale: visible ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton.small(
          tooltip: 'Back to top',
          backgroundColor: const Color(0xFF40DCC7),
          onPressed: () {
            controller.animateTo(
              0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          },
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
