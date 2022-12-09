part of 'record_overview_bloc.dart';

abstract class RecordOverviewEvent extends Equatable {
  const RecordOverviewEvent();

  @override
  List<Object> get props => [];
}

class RecordOverviewRecordDeleted extends RecordOverviewEvent {}

class RecordOverviewUndoDeletionRequested extends RecordOverviewEvent {}
