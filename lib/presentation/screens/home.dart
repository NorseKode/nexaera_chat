import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            children: []))))));
  }
}
