part of 'domain_bloc.dart';

abstract class DomainState extends Equatable {
  const DomainState(this.domainList);

  final List<DomainModel> domainList;

  @override
  List<Object> get props => [domainList];
}

class DomainListLoading extends DomainState {
  const DomainListLoading() : super(const []);
}

class DomainListLoaded extends DomainState {
  const DomainListLoaded(super.domainList);
}
