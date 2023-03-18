import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/blocs/domain/domain_bloc.dart';
import 'package:nexaera_chat/data/repositories/domain_repository.dart';
import 'package:nexaera_chat/presentation/sections/add_domain.dart';
import 'package:nexaera_chat/presentation/components/custom_drop_down.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:unicons/unicons.dart';

import '../../data/models/domain_model.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class WorkshopScreen extends StatelessWidget {
  WorkshopScreen({super.key});

  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    //Include search functionalitites
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
                              const AddDomain(),
                              const SizedBox(height: 32),
                              Text("Your data",
                                  style: _theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              BlocBuilder<DomainBloc, DomainState>(
                                  builder: (context, state) {
                                if (state is DomainListLoaded) {
                                  if (state.selectedDomain == null &&
                                      state.domainList.isEmpty) {
                                    return const Text(
                                        "You haven't provided a domain or any documents");
                                  }
                                  if (state.selectedDomain == null) {
                                    context.read<DomainBloc>().add(
                                        DomainSelected(state.domainList
                                            .elementAt(0)
                                            .uid!));
                                    return const CircularProgressIndicator();
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _domainDropDown(
                                          state.domainList,
                                          state.selectedDomain!,
                                          (id) => state.selectedDomain == id
                                              ? null
                                              : context
                                                  .read<DomainBloc>()
                                                  .add(DomainSelected(id))),
                                      const SizedBox(height: 32),
                                      Text(
                                          'Detailed view of: ${state.selectedDomain!}')
                                    ],
                                  );
                                } else {
                                  context
                                      .read<DomainBloc>()
                                      .add(FetchDomainList());
                                  return const CircularProgressIndicator();
                                }
                              }),
                            ]))))));
  }

  // Widget _domainList(List<DomainModel> domains, String? selected,
  //     Function(dynamic) onSelected) {
  //   return Container(
  //     width: 200,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: List.generate(
  //           domains.length,
  //           (index) => GestureDetector(
  //                 behavior: HitTestBehavior.translucent,
  //                 onTap: () => onSelected(domains.elementAt(index).uid),
  //                 child: Text(
  //                   domains.elementAt(index).domain,
  //                   style: TextStyle(
  //                       color: domains.elementAt(index).uid == selected
  //                           ? _theme.colorScheme.primary
  //                           : null),
  //                 ),
  //               )),
  //     ),
  //   );
  // }

  //Doesn't update unless you delete the input of the menu
  Widget _domainDropDown(List<DomainModel> domains, String selected,
      Function(dynamic) onSelected) {
    return CustomDropDown(
      selected: selected,
      items: List.generate(domains.length, (index) {
        var domain = domains.elementAt(index);
        return CustomDropdownItem(value: domain.uid, label: domain.domain);
      }),
      onSelected: onSelected,
    );
  }
}
