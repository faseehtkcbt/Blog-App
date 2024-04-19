import 'package:blog_app/core/theme/app_pallete.dart';

import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/app_gerdient_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/route/routes.dart';
import '../../../../core/utils/widgets/app_text.dart';
import '../../../../core/utils/widgets/loader.dart';
import '../../../../core/utils/widgets/showSnack.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ShowSnackBar(context, state.message);
            }
            if (state is AuthSuccess) {
              ShowSnackBar(context,
                  "Hai ${state.uid.name}. You are Successfully Logined!!");
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Sign Up",
                    fontWeight: FontWeight.w700,
                    txtSize: 50,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                      hintText: 'Name', textEditingController: nameController),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                      hintText: 'Email',
                      textEditingController: emailController),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                      hintText: 'Password',
                      isObscure: true,
                      textEditingController: passwordController),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthGradientButton(
                    text: 'Sign Up',
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        /*context.read<AuthBloc>().add(AuthSignUp(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));*/
                        BlocProvider.of<AuthBloc>(context).add(AuthSignUp(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim()));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context, Routes.signInPage, (route) => false),
                    child: RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.w600),
                          )
                        ])),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
