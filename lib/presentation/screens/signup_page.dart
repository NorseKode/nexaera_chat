import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../blocs/authentication/auth.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    _auth = context.read<AuthProvider>();
    var theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: 300,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Welcome to ',
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                              text: 'Nexæra',
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Sign up with email',
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(height: 35),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Email address'),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 35),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          padding: const EdgeInsets.all(16)),
                      onPressed: trySignUp,
                      child: Text("Sign up",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.colorScheme.onPrimary)),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: theme.colorScheme.surface,
                          padding: const EdgeInsets.all(16)),
                      onPressed: () => context.go('/signin'),
                      child: Text("Already registered? Log in",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.colorScheme.onSurface)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void trySignUp() {
    if (formKey.currentState?.validate() ?? false) {
      _auth.signUp(emailController.text, passwordController.text);
    }
  }
}
