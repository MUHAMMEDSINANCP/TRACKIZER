import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class CustomUnderLine extends StatelessWidget {
  const CustomUnderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: TColor.gray70,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: TColor.gray70,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: TColor.gray70,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: TColor.gray70,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: TColor.gray70,
            ),
          ),
        )
      ],
    );
  }
}
