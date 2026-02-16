part of 'favourites_bloc.dart';

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class FavouritesOnAppear extends FavouritesEvent {}

class FavouritesOnRemoveFavorite extends FavouritesEvent {
  final String startupId;

  const FavouritesOnRemoveFavorite({required this.startupId});

  @override
  List<Object> get props => [startupId];
}

class FavouritesOnStartupTapped extends FavouritesEvent {
  final String startupId;

  const FavouritesOnStartupTapped({required this.startupId});

  @override
  List<Object> get props => [startupId];
}

class FavouritesOnReturned extends FavouritesEvent {}

class FavouritesOnPullToRefresh extends FavouritesEvent {}
