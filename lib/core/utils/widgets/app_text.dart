import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppText extends StatefulWidget {
  final String text;
  final Color txtColor;
  final FontWeight fontWeight;
  final double txtSize;
  final TextOverflow textOverFlow;
  final int maxLines;
  const AppText(
      {super.key,
      required this.text,
      this.txtColor = AppPallete.whiteColor,
      this.fontWeight = FontWeight.w400,
      this.txtSize = 14,
      this.textOverFlow = TextOverflow.visible,
      this.maxLines = 1});

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: widget.maxLines,
      style: TextStyle(
        fontWeight: widget.fontWeight,
        overflow: widget.textOverFlow,
        color: widget.txtColor,
        fontSize: widget.txtSize,
      ),
    );
  }
}
