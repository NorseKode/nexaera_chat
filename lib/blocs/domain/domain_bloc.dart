import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/domain_model.dart';
import '../../data/repositories/domain_repository.dart';

part 'domain_event.dart';
part 'domain_state.dart';

class DomainBloc extends Bloc<DomainEvent, DomainState> {
  final DomainRepository _domainRepository;
  DomainBloc(this._domainRepository) : super(const DomainListLoading()) {
    on<FetchDomainList>((event, emit) async {
      await emit.forEach(_domainRepository.streamDomains(),
          onData: (List<DomainModel> domainList) =>
              DomainListLoaded(domainList));
    });
  }
}
