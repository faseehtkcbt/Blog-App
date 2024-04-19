import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

void ShowLoadingDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => Loader());
}
