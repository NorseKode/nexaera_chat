import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nexaera_chat/blocs/authentication/auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';
import 'package:nexaera_chat/data/models/scrape_progress.dart';
import 'package:nexaera_chat/data/repositories/domain_repository.dart';
import 'package:nexaera_chat/data/repositories/nexaera_repository.dart';

part 'upload_domain_event.dart';
part 'upload_domain_state.dart';

class UploadDomainBloc extends Bloc<UploadDomainEvent, UploadDomainState> {
  UploadDomainBloc(this._nexaeraRepository, this._auth, this._domainRepository)
      : super(UploadDomainInitial()) {
    on<UploadDomain>((event, emit) async {
      try {
        emit(const ScrapeInProgress(123, 'Loading...', ''));
        Duration(seconds: 4);
        var accessToken = await _auth.user!.getIdToken();
        await _domainRepository.addDomain(DomainModel(
            domain: event.domain, altDomains: List<String>.empty()));
        // await emit.forEach(
        //     _nexaeraRepository.uploadDomain(event.domain, accessToken),
        //     onData: (ScrapeProgressModel progress) => ScrapeInProgress(
        //         progress.statusCode, progress.message, progress.urlInProgress));
        emit(const UploadDone(200, 'Done'));
      } on Exception catch (e) {
        emit(UploadError(e));
      }
    });
  }

  final NexaeraRepository _nexaeraRepository;
  final DomainRepository _domainRepository;
  final AuthProvider _auth;
}
