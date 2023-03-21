import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/blocs/domain/domain_bloc.dart';
import 'package:nexaera_chat/presentation/sections/add_domain.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/sections/resource_list.dart';

import '../components/custom_app_bar.dart';

class LabScreen extends StatelessWidget {
  LabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    //Include search functionalitites
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Headline(title: 'Lab'),
                              const SizedBox(height: 32),
                              const AddDomain(),
                              const SizedBox(height: 32),
                              Text('Resources',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              BlocBuilder<DomainBloc, DomainState>(
                                  builder: (context, state) {
                                if (state is DomainListLoaded) {
                                  if (state.domainList.isEmpty) {
                                    return const Text(
                                        "You haven't provided a domain or any documents");
                                  }

                                  return ResourceList(
                                      resources: state.domainList
                                          .map((e) => Resource(
                                              e.domain,
                                              DateTime.now(),
                                              ResourceStatus.inChatContext))
                                          .toList());
                                } else {
                                  context
                                      .read<DomainBloc>()
                                      .add(FetchDomainList());
                                  return const CircularProgressIndicator();
                                }
                              }),
                            ]))))));
  }
}
