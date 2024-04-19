import 'package:flutter/material.dart';

import 'app_text.dart';

void ShowSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        content: AppText(
      text: content,
      txtColor: Colors.black87,
    )));
}
