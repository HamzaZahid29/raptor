import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raptor/core/router/static_app_routes.dart';
import 'package:raptor/core/theme/theme.dart';
import 'package:raptor/core/utils/show_snackbar.dart';
import 'package:raptor/core/validators/text_field_validators.dart';

import '../../../../core/theme/text_styles.dart';
import '../blocs/auth_bloc.dart';
import '../widgets/auth_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Login')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackbar(context, state.messege);
          } else if (state is AuthSuccess) {
            showSnackbar(context, "User Created Successfully!");
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is AuthInitial) {
            return Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthTextFormField(
                        textEditingController: emailController,
                        label: 'Email',
                        formFieldValidator: TextFieldValidators.emailValidator,
                      ),
                      const SizedBox(height: 10),
                      AuthTextFormField(
                        textEditingController: passwordController,
                        label: 'Password',
                        formFieldValidator:
                            TextFieldValidators.passwordValidator,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(AuthLogin(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ));
                                }
                              },
                              child: Text('Login',),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: '''Don't have an account ? ''',
                            style: AppTextStyles.labelLarge(context),
                            children: [
                              TextSpan(
                                  text: '''Sign Up''',
                                  style: AppTextStyles.labelLarge(context),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Get.toNamed(AppRoutes.signUpScreen);
                                      context.pushNamed(Routes.signupScreen);
                                    })
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is AuthSuccess) {
            return Center(
              child: Text('User created Successfully'),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
