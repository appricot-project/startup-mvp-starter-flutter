part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainOnAppear extends MainEvent {}

enum ActionType { favourite, details }

class MainOnActionButtonTapped extends MainEvent {
  final ActionType type;
  final dynamic value;

  const MainOnActionButtonTapped({required this.type, this.value});
}

class MainOnSortSelected extends MainEvent {
  final SortType sortType;

  const MainOnSortSelected({required this.sortType});
}
