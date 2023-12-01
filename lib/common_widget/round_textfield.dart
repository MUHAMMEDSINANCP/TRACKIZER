import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onPasswordChanged;
  final String? Function(String?)? validator;

  const RoundTextField(
      {super.key,
      required this.title,
      this.titleAlign = TextAlign.left,
      this.controller,
      this.keyboardType,
      this.obscureText = false,
      this.suffixIcon,
      this.validator, this.onPasswordChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: titleAlign,
                style: TextStyle(color: TColor.gray50, fontSize: 12),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: TColor.gray60.withOpacity(0.05),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextSelectionTheme(
              data: TextSelectionThemeData(
                selectionColor: TColor.white,
              ),
              child: TextFormField(
                validator: validator,
                cursorColor: TColor.secondary,
                cursorOpacityAnimates: true,
                showCursor: true,
                style: TextStyle(
                  color: TColor.secondary,
                ),
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                keyboardType: keyboardType,
                obscureText: obscureText,
              onChanged: (password) {
            if (onPasswordChanged != null) {
              onPasswordChanged!(password);
            }
          },
              ),
            ),
          ),
          
        ),
      ],
    );
  }
}
