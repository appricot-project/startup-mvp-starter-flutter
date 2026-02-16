part of 'main_details_bloc.dart';

sealed class MainDetailsState extends Equatable {
  final Loading? loading;
  final StartupDetailsModel? model;
  const MainDetailsState({required this.loading, required this.model});

  @override
  List<Object?> get props => [loading, model];
}

enum Loading { initial, refresh }

final class MainDetailsInitial extends MainDetailsState {
  MainDetailsInitial({required super.loading, required super.model});
}

final class MainDetailsUpdated extends MainDetailsState {
  MainDetailsUpdated({required super.loading, required super.model});
}

final class MainDetailsError extends MainDetailsState {
  final String error;
  MainDetailsError({
    required this.error,
    required super.loading,
    required super.model,
  });

  @override
  List<Object?> get props => [super.props, error];
}
