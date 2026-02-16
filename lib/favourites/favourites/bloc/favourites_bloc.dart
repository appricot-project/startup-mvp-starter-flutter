import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final MainService mainService;
  final SharedStorage sharedStorage;

  Loading? loading = Loading.initial;
  List<StartupModel> startups = [];

  FavouritesBloc({required this.mainService, required this.sharedStorage})
    : super(FavouritesInitial(loading: Loading.initial, startups: [])) {
    on<FavouritesOnAppear>((event, emit) async {
      loading = Loading.initial;
      _emitUpdatedState(emit);

      await _loadingFavourites(emit);

      loading = null;
      _emitUpdatedState(emit);
    });

    on<FavouritesOnRemoveFavorite>((event, emit) async {
      await mainService.removeFavoriteId(event.startupId);

      final favoriteIdsResponse = await mainService.getFavoriteIds();
      List<String> favoriteIds = [];
      favoriteIdsResponse.fold(
        (l) => _emitErrorState(emit, l.message),
        (r) => favoriteIds = r ?? [],
      );

      startups = startups.where((s) => favoriteIds.contains(s.id)).toList();
      _emitUpdatedState(emit);
    });

    on<FavouritesOnStartupTapped>((event, emit) {
      emit(
        FavouritesShowView(
          startupId: event.startupId,
          loading: loading,
          startups: List.from(startups),
        ),
      );
    });

    on<FavouritesOnReturned>((event, emit) async {
      final startupsResponse = await mainService.getStartups();
      List<StartupModel> allStartups = [];
      startupsResponse.fold(
        (l) => _emitErrorState(emit, l.message),
        (r) => allStartups = r,
      );

      final favoriteIdsResponse = await mainService.getFavoriteIds();
      List<String> favoriteIds = [];
      favoriteIdsResponse.fold(
        (l) => _emitErrorState(emit, l.message),
        (r) => favoriteIds = r ?? [],
      );

      startups = allStartups.where((s) => favoriteIds.contains(s.id)).toList();
      _emitUpdatedState(emit);
    });

    on<FavouritesOnPullToRefresh>((event, emit) async {
      loading = Loading.refresh;
      _emitUpdatedState(emit);

      await _loadingFavourites(emit);

      loading = null;
      _emitUpdatedState(emit);
    });
  }

  Future<void> _loadingFavourites(Emitter<FavouritesState> emit) async {
    final startupsResponse = await mainService.getStartups();
    List<StartupModel> allStartups = [];
    startupsResponse.fold(
      (l) => _emitErrorState(emit, l.message),
      (r) => allStartups = r,
    );

    final favoriteIdsResponse = await mainService.getFavoriteIds();
    List<String> favoriteIds = [];
    favoriteIdsResponse.fold(
      (l) => _emitErrorState(emit, l.message),
      (r) => favoriteIds = r ?? [],
    );

    startups = allStartups.where((s) => favoriteIds.contains(s.id)).toList();
  }

  _emitUpdatedState(Emitter<FavouritesState> emit) {
    emit(FavouritesUpdated(loading: loading, startups: List.from(startups)));
  }

  _emitErrorState(Emitter<FavouritesState> emit, String error) {
    emit(
      FavouritesError(
        error: error,
        loading: loading,
        startups: List.from(startups),
      ),
    );
  }
}
