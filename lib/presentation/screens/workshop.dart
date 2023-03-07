import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/blocs/domain/domain_bloc.dart';
import 'package:nexaera_chat/data/repositories/domain_repository.dart';
import 'package:nexaera_chat/presentation/components/custom_drop_down.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:unicons/unicons.dart';

import '../../data/models/domain_model.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class WorkshopScreen extends StatelessWidget {
  WorkshopScreen({super.key});

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
                            children: [
                              const Headline(title: 'Workshop'),
                              const SizedBox(height: 32),
                              BlocBuilder<DomainBloc, DomainState>(
                                  builder: (context, state) {
                                if (state is DomainListLoaded) {
                                  return _domainDropDown(
                                      state.domainList,
                                      state.selectedDomain,
                                      (id) => context
                                          .read<DomainBloc>()
                                          .add(DomainSelected(id)));
                                } else {
                                  context
                                      .read<DomainBloc>()
                                      .add(FetchDomainList());
                                  return const CircularProgressIndicator();
                                }
                              })
                            ]))))));
  }

  Widget _domainDropDown(List<DomainModel> domains, String? selected,
      Function(dynamic) onSelected) {
    return CustomDropDown(
      selected: selected ?? domains.elementAt(0).uid!,
      items: List.generate(domains.length, (index) {
        var domain = domains.elementAt(index);
        return CustomDropdownItem(value: domain.uid, label: domain.domain);
      }),
      onSelected: onSelected,
    );
  }
}
