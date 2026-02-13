part of 'main_bloc.dart';

sealed class MainState extends Equatable {
  final Loading? loading;
  final List<StartupModel> startups;
  final List<String> favoriteIds;
  final List<String> viewedIds;
  final SortType currentSortType;
  const MainState({
    required this.loading,
    required this.startups,
    required this.favoriteIds,
    required this.viewedIds,
    required this.currentSortType,
  });

  @override
  List<Object?> get props => [
    loading,
    startups,
    favoriteIds,
    viewedIds,
    currentSortType,
  ];
}

enum Loading { initial, refresh }

enum SortType { newest, favorites, recentViewed }

final class MainInitial extends MainState {
  MainInitial({
    required super.loading,
    required super.startups,
    required super.favoriteIds,
    required super.viewedIds,
    required super.currentSortType,
  });
}

final class MainUpdated extends MainState {
  MainUpdated({
    required super.loading,
    required super.startups,
    required super.favoriteIds,
    required super.viewedIds,
    required super.currentSortType,
  });
}

final class MainError extends MainState {
  final String error;
  MainError({
    required this.error,
    required super.loading,
    required super.startups,
    required super.favoriteIds,
    required super.viewedIds,
    required super.currentSortType,
  });

  @override
  List<Object?> get props => [super.props, error];
}

enum ViewKey { details }

final class MainShowView extends MainState {
  final ViewKey key;
  final dynamic data;
  MainShowView({
    required this.key,
    this.data,
    required super.loading,
    required super.startups,
    required super.favoriteIds,
    required super.viewedIds,
    required super.currentSortType,
  });

  @override
  List<Object?> get props => [super.props, key, data];
}
