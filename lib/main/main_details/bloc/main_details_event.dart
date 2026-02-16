part of 'main_details_bloc.dart';

sealed class MainDetailsEvent extends Equatable {
  const MainDetailsEvent();

  @override
  List<Object> get props => [];
}

class MainDetailsOnAppear extends MainDetailsEvent {}

class MainDetailsOnFavoriteTapped extends MainDetailsEvent {}

class MainDetailsOnPullToRefresh extends MainDetailsEvent {}
