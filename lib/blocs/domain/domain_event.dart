part of 'domain_bloc.dart';

abstract class DomainEvent extends Equatable {
  const DomainEvent();

  @override
  List<Object> get props => [];
}

class FetchDomainList extends DomainEvent {}

class DomainSelected extends DomainEvent {
  final String selectedDomainId;
  const DomainSelected(this.selectedDomainId);
}
