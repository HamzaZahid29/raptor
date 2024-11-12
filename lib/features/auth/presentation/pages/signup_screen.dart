import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raptor/core/utils/show_snackbar.dart';
import 'package:raptor/core/validators/text_field_validators.dart';

import '../../../../core/theme/text_styles.dart';
import '../blocs/auth_bloc.dart';
import '../widgets/auth_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
// disp

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Sign Up', style: AppTextStyles.headlineMedium(context))),
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
                        textEditingController: userNameController,
                        label: 'Username',
                        formFieldValidator:
                            TextFieldValidators.userNameValidator,
                      ),
                      const SizedBox(height: 10),
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
                                  context.read<AuthBloc>().add(AuthSignUp(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        name: userNameController.text.trim(),
                                      ));
                                }
                              },
                              child: Text('Sign Up',
                                  style: AppTextStyles.labelLarge(context)),
                            ),
                          ),
                        ],
                      ),
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
