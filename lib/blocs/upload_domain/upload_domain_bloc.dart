import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nexaera_chat/app/auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';
import 'package:nexaera_chat/data/models/scrape_progress.dart';
import 'package:nexaera_chat/data/repositories/domain_repository.dart';
import 'package:nexaera_chat/data/repositories/server_repository.dart';

part 'upload_domain_event.dart';
part 'upload_domain_state.dart';

class UploadDomainBloc extends Bloc<UploadDomainEvent, UploadDomainState> {
  UploadDomainBloc(this._serverRepository, this._auth, this._domainRepository)
      : super(UploadDomainInitial()) {
    on<UploadDomain>((event, emit) async {
      emit(const ScrapeInProgress(123, 'Loading...', ''));
      Future.delayed(const Duration(seconds: 2));

      try {
        print(Uri.parse(event.domain).isAbsolute);
        var accessToken = await _auth.user!.getIdToken();
        var progressStream =
            _serverRepository.uploadDomain(event.domain, accessToken);

        await emit.forEach(
          progressStream,
          onData: (ScrapeProgressModel progress) => ScrapeInProgress(
              progress.statusCode, progress.message, progress.urlInProgress),
        );

        await _domainRepository.addDomain(DomainModel(
            domain: event.domain, altDomains: List<String>.empty()));

        emit(const UploadDone(200, 'Done'));
      } on FormatException catch (e) {
        emit(UploadError("Incorrect domain: ${e.message}"));
      } catch (e) {
        emit(UploadError(e.toString()));
      }
    });
  }

  final ServerRepository _serverRepository;
  final DomainRepository _domainRepository;
  final AuthProvider _auth;
}
