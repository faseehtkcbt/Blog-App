import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppPallete.backgroundColor),
      child: const CircularProgressIndicator(
        color: AppPallete.whiteColor,
      ),
    );
  }
}
