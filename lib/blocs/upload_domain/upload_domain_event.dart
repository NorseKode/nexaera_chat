part of 'upload_domain_bloc.dart';

abstract class UploadDomainEvent extends Equatable {
  const UploadDomainEvent();

  @override
  List<Object> get props => [];
}

class UploadDomain extends UploadDomainEvent {
  final String domain;
  const UploadDomain(this.domain);
}
