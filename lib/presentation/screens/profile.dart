import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/data/models/user_model.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:unicons/unicons.dart';

import '../../app/auth.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var emailController = TextEditingController();
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
                        child: FutureBuilder(
                            future: context
                                .read<AuthProvider>()
                                .getCurrentUserDetails(),
                            builder: (context, snapshot) {
                              firstnameController.text =
                                  snapshot.data?.firstName ?? '';
                              lastnameController.text =
                                  snapshot.data?.lastName ?? '';
                              emailController.text = snapshot.data?.email ?? '';
                              return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Headline(title: 'Profile'),
                                    const SizedBox(height: 32),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: const Text('First name')),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomTextField(
                                            hint: '',
                                            controller: firstnameController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: const Text('Last name')),
                                        const SizedBox(width: 16),
                                        Expanded(
                                            child: CustomTextField(
                                          hint: '',
                                          controller: lastnameController,
                                        )),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: const Text('Email')),
                                        const SizedBox(width: 16),
                                        Expanded(
                                            child: CustomTextField(
                                          hint: emailController.text,
                                          readOnly: true,
                                        )),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () => context
                                                .read<AuthProvider>()
                                                .updateUserInfo(
                                                    firstnameController.text,
                                                    lastnameController.text),
                                            child: const Text('Save profile')),
                                        const SizedBox(height: 24),
                                        ElevatedButton(
                                            onPressed: () => context
                                                .read<AuthProvider>()
                                                .signOut(),
                                            child: const Text('Sign Out'))
                                      ],
                                    )
                                  ]);
                            }))))));
  }
}
