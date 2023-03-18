import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';

import '../../app/auth.dart';
import '../../blocs/user/user_bloc.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var emailController = TextEditingController();
    var auth = context.read<AuthProvider>();

    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Headline(title: 'Account'),
                              const SizedBox(height: 32),
                              BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                if (state is UserInitial) {
                                  context
                                      .read<UserBloc>()
                                      .add(GetUserDetails(auth.user!.uid));
                                }

                                if (state is UserLoaded) {
                                  firstnameController.text = state.firstName;
                                  lastnameController.text = state.lastName;
                                  emailController.text = state.email;
                                }

                                return Column(children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text('First name')),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomTextField(
                                            hint: '',
                                            controller: firstnameController,
                                            readOnly: state is! UserLoaded),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text('Last name')),
                                      const SizedBox(width: 16),
                                      Expanded(
                                          child: CustomTextField(
                                        hint: '',
                                        controller: lastnameController,
                                        readOnly: state is! UserLoaded,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text('Email')),
                                      const SizedBox(width: 16),
                                      Expanded(
                                          child: CustomTextField(
                                        hint: emailController.text,
                                        readOnly: true,
                                      )),
                                    ],
                                  ),
                                ]);
                              }),
                              const SizedBox(height: 32),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () => auth.updateUserInfo(
                                          firstnameController.text,
                                          lastnameController.text),
                                      child: const Text('Save Account')),
                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                      onPressed: () => auth.signOut(),
                                      child: const Text('Sign Out'))
                                ],
                              )
                            ]))))));
  }
}
