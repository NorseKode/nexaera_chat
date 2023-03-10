import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:unicons/unicons.dart';

import '../../blocs/authentication/auth.dart';
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Headline(title: 'Profile'),
                              const SizedBox(height: 32),
                              CustomTextField(
                                hint: '',
                                controller: firstnameController,
                                prefixText: 'First name',
                              ),
                              CustomTextField(
                                hint: '',
                                prefixText: 'Last name',
                                controller: lastnameController,
                              ),
                              CustomTextField(
                                hint: '',
                                readOnly: true,
                                prefixText: 'Email',
                                controller: emailController,
                              ),
                              ElevatedButton(
                                  onPressed: () =>
                                      context.read<AuthProvider>().signOut(),
                                  child: const Text('Save profile')),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                  onPressed: () =>
                                      context.read<AuthProvider>().signOut(),
                                  child: const Text('Sign Out'))
                            ]))))));
  }
}
