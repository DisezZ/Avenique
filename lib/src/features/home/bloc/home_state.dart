part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.accountStream,
    required this.recordStream,
  });

  final Stream<List<Account>> accountStream;
  final Stream<List<Record>> recordStream;
  
  @override
  List<Object> get props => [accountStream, recordStream];
}