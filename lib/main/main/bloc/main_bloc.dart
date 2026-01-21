import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final SharedStorage sharedStorage;
  final MainService mainService;

  Loading? loading = Loading.initial;
  List<StartupModel> startups = [];
  List<String> favoriteIds = [];
  List<String> viewedIds = [];
  SortType currentSortType = SortType.newest;

  MainBloc({required this.sharedStorage, required this.mainService})
    : super(
        MainInitial(
          loading: Loading.initial,
          startups: [],
          favoriteIds: [],
          viewedIds: [],
          currentSortType: SortType.newest,
        ),
      ) {
    on<MainOnAppear>((event, emit) async {
      loading = Loading.initial;
      _emitUpdatedState(emit);
      final response = await mainService.getStartups();
      response.fold((l) {}, (r) {
        startups = r.map((e) => StartupModel.fromDto(e)).toList();
        sortStartups();
      });
      favoriteIds = await sharedStorage.getFavoriteIds();
      viewedIds = await sharedStorage.getViewedIds();
      loading = null;
      _emitUpdatedState(emit);
    });
    on<MainOnActionButtonTapped>((event, emit) async {
      switch (event.type) {
        case ActionType.favourite:
          String startupId = event.value as String;
          if (favoriteIds.contains(startupId)) {
            await sharedStorage.removeFavoriteId(startupId);
          } else {
            await sharedStorage.addFavoriteId(startupId);
          }
          favoriteIds = await sharedStorage.getFavoriteIds();
          _emitUpdatedState(emit);
          break;
        case ActionType.details:
          break;
      }
    });
    on<MainOnSortSelected>((event, emit) {
      currentSortType = event.sortType;
      sortStartups();
      _emitUpdatedState(emit);
    });
  }

  void sortStartups() {
    switch (currentSortType) {
      case SortType.newest:
        startups.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortType.favorites:
        startups.sort((a, b) {
          final aFav = favoriteIds.contains(a.id) ? 1 : 0;
          final bFav = favoriteIds.contains(b.id) ? 1 : 0;
          return bFav.compareTo(aFav);
        });
        break;
      case SortType.recentViewed:
        startups.sort((a, b) {
          final aViewedIndex = viewedIds.indexOf(a.id);
          final bViewedIndex = viewedIds.indexOf(b.id);
          return aViewedIndex.compareTo(bViewedIndex);
        });
        break;
    }
  }

  _emitUpdatedState(Emitter<MainState> emit) {
    emit(
      MainUpdated(
        loading: loading,
        startups: List.from(startups),
        favoriteIds: List.from(favoriteIds),
        viewedIds: List.from(viewedIds),
        currentSortType: currentSortType,
      ),
    );
  }
}
