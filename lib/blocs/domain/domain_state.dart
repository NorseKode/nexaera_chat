part of 'domain_bloc.dart';

abstract class DomainState extends Equatable {
  const DomainState(this.domainList, this.selectedDomain);

  final List<DomainModel> domainList;
  final String? selectedDomain;

  @override
  List<Object> get props => [domainList, selectedDomain ?? ""];
}

class DomainListLoading extends DomainState {
  const DomainListLoading() : super(const [], null);
}

class DomainListLoaded extends DomainState {
  const DomainListLoaded(super.domainList, super.selectedDomain);
}
