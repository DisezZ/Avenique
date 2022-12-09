import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/record_repository.dart';

part 'record_overview_event.dart';
part 'record_overview_state.dart';

class RecordOverviewBloc extends Bloc<RecordOverviewEvent, RecordOverviewState> {
  RecordOverviewBloc({
    required RecordRepository recordRepository,
  }) : _recordRepository = recordRepository, super(RecordOverviewInitial()) {
    on<RecordOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final RecordRepository _recordRepository;
}
