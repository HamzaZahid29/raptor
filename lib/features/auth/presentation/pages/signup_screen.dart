import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raptor/core/validators/text_field_validators.dart';

import '../../../../core/theme/text_styles.dart';
import '../blocs/auth_bloc.dart';
import '../widgets/auth_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('SignUp', style: AppTextStyles.headlineMedium)),
      body: Form(
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
                  formFieldValidator: TextFieldValidators.userNameValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthTextFormField(
                  textEditingController: emailController,
                  label: 'Email',
                  formFieldValidator: TextFieldValidators.emailValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthTextFormField(
                  textEditingController: passwordController,
                  label: 'Password',
                  formFieldValidator: TextFieldValidators.passwordValidator,
                ),
                SizedBox(height: 20),
                //
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator();
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(AuthSignUp(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: userNameController.text.trim()));
                              }
                            },
                            child:
                                Text('SignUp', style: AppTextStyles.labelLarge),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
