import 'package:flutter/material.dart';

class CustomUnderLine extends StatelessWidget {
  final Color passwordColor;

  const CustomUnderLine({super.key, required this.passwordColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: passwordColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: passwordColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: passwordColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: passwordColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: passwordColor,
            ),
          ),
        )
      ],
    );
  }
}
