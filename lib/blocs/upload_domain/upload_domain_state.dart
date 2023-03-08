part of 'upload_domain_bloc.dart';

abstract class UploadDomainState extends Equatable {
  const UploadDomainState();

  @override
  List<Object> get props => [];
}

class UploadDomainInitial extends UploadDomainState {}

class ScrapeInProgress extends UploadDomainState {
  final int status;
  final String message;
  final String urlInProgress;

  const ScrapeInProgress(this.status, this.message, this.urlInProgress);
}

class UploadDone extends UploadDomainState {
  final int status;
  final String message;

  const UploadDone(this.status, this.message);
}

class UploadError extends UploadDomainState {
  final Exception e;

  const UploadError(this.e);
}
