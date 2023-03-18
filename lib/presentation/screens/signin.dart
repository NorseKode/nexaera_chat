import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/presentation/components/custom_text_field.dart';
import 'package:nexaera_chat/presentation/components/error_box.dart';

import '../../app/auth.dart';
import '../../blocs/sign_in/sign_in_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    _auth = context.read<AuthProvider>();
    var theme = Theme.of(context);

    return Scaffold(
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(_auth),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: SizedBox(
                width: 300,
                child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome back',
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Log in to your account',
                              style: theme.textTheme.headlineSmall),
                          const SizedBox(height: 24),
                          CustomTextField(
                              hint: 'Email address',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress),
                          const SizedBox(height: 16),
                          CustomTextField(
                            hint: 'Password',
                            controller: passwordController,
                            obscureText: true,
                            onSubmitted: (e) => context.read<SignInBloc>().add(
                                SigningIn(emailController.text,
                                    passwordController.text)),
                          ),
                          // const SizedBox(height: 25),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     TextButton(
                          //         onPressed: () {},
                          //         child: const Text("Forgot password?"))
                          //   ],
                          // ),
                          const SizedBox(height: 24),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                padding: const EdgeInsets.all(16)),
                            onPressed: () => context.read<SignInBloc>().add(
                                SigningIn(emailController.text,
                                    passwordController.text)),
                            child: Text("Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: theme.colorScheme.onPrimary)),
                          ),
                          //const SizedBox(height: 15),
                          // TextButton(
                          //   style: TextButton.styleFrom(
                          //       backgroundColor: theme.colorScheme.surface,
                          //       padding: const EdgeInsets.all(16)),
                          //   onPressed: () => context.go('/signup'),
                          //   child: Text("Not registered? Sign up",
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //           color: theme.colorScheme.onSurface)),
                          // ),
                          if (state is SignInError) errorBox(state.message)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget errorBox(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: ErrorBox(message),
    );
  }
}
