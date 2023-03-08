import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nexaera_chat/blocs/authentication/auth.dart';
import 'package:nexaera_chat/data/models/scrape_progress.dart';
import 'package:nexaera_chat/data/repositories/nexaera_repository.dart';

part 'upload_domain_event.dart';
part 'upload_domain_state.dart';

class UploadDomainBloc extends Bloc<UploadDomainEvent, UploadDomainState> {
  UploadDomainBloc(this._nexaeraRepository, this._auth)
      : super(UploadDomainInitial()) {
    on<UploadDomain>((event, emit) async {
      try {
        emit(const ScrapeInProgress(123, 'Loading...', ''));
        Duration(seconds: 4);
        var accessToken = await _auth.user!.getIdToken();
        await emit.forEach(
            _nexaeraRepository.uploadDomain(event.domain, accessToken),
            onData: (ScrapeProgressModel progress) => ScrapeInProgress(
                progress.statusCode, progress.message, progress.urlInProgress));
      } on Exception catch (e) {
        emit(UploadError(e));
      }
    });
  }

  final NexaeraRepository _nexaeraRepository;
  final AuthProvider _auth;
}
