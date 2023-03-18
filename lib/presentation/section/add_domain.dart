import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../blocs/upload_domain/upload_domain_bloc.dart';
import '../components/custom_text_field.dart';
import '../components/paragraph_text.dart';

class AddDomain extends StatelessWidget {
  const AddDomain({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<UploadDomainBloc, UploadDomainState>(
        builder: (context, state) {
      if (state is UploadDone) {
        return const Text("Upload completed");
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add your domain', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          const Paragraph(
              "In order to get started, please input a domain that you own"),
          const SizedBox(height: 8),
          const Paragraph(
            "Nexæra scans this domain for all information available and you will be able to interact with it through our chat",
          ),
          const SizedBox(height: 24),
          CustomTextField(
            readOnly: state is ScrapeInProgress,
            hint: 'yourdomain.com',
            onSubmitted: (value) =>
                context.read<UploadDomainBloc>().add(UploadDomain(value)),
            prefixIcon: UniconsLine.at,
            suffixIcon: UniconsLine.arrow_right,
          ),
          state is! ScrapeInProgress
              ? Container()
              : Column(
                  children: [
                    const SizedBox(height: 4, child: LinearProgressIndicator()),
                    const SizedBox(height: 12),
                    Text('Status: ${state.status}, ${state.message}')
                  ],
                ),
          state is! UploadError
              ? Container()
              : Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(state.e.toString()),
                  ],
                ),
        ],
      );
    });
  }
}
