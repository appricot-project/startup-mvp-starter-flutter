part of 'favourites_bloc.dart';

enum Loading { initial, refresh }

sealed class FavouritesState extends Equatable {
  final Loading? loading;
  final List<StartupModel> startups;

  const FavouritesState({required this.loading, required this.startups});

  @override
  List<Object?> get props => [loading, startups];
}

final class FavouritesInitial extends FavouritesState {
  FavouritesInitial({required super.loading, required super.startups});
}

final class FavouritesUpdated extends FavouritesState {
  FavouritesUpdated({required super.loading, required super.startups});
}

final class FavouritesError extends FavouritesState {
  final String error;

  FavouritesError({
    required this.error,
    required super.loading,
    required super.startups,
  });

  @override
  List<Object?> get props => [super.props, error];
}

final class FavouritesShowView extends FavouritesState {
  final String startupId;

  FavouritesShowView({
    required this.startupId,
    required super.loading,
    required super.startups,
  });

  @override
  List<Object?> get props => [super.props, startupId];
}
