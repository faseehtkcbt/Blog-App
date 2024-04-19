import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/app_text.dart';

class AuthGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const AuthGradientButton(
      {super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
              colors: [AppPallete.gradient1, AppPallete.gradient2],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight)),
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: AppPallete.transparentColor),
        child: AppText(
          text: text,
          fontWeight: FontWeight.w600,
          txtSize: 17,
        ),
      ),
    );
  }
}
