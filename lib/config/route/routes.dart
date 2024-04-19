import 'package:blog_app/features/auth/presentation/pages/sign_in.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/sign_up.dart';

class Routes {
  Routes._();

  static const String signInPage = '/sign_in';
  static const String signUpPage = '/sign_up';

  static final dynamic routes = <String, WidgetBuilder>{
    '/sign_in': (BuildContext context) => const SignInPage(),
    '/sign_up': (BuildContext context) => const SignUpPage()
  };
}
