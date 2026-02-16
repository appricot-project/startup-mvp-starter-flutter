import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/models/startup_details_model.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

part 'main_details_event.dart';
part 'main_details_state.dart';

class MainDetailsBloc extends Bloc<MainDetailsEvent, MainDetailsState> {
  final String startupId;
  final MainService mainService;
  final SharedStorage sharedStorage;

  Loading? loading = Loading.initial;
  StartupDetailsModel? model;

  MainDetailsBloc({
    required this.startupId,
    required this.mainService,
    required this.sharedStorage,
  }) : super(MainDetailsInitial(loading: Loading.initial, model: null)) {
    on<MainDetailsOnAppear>((event, emit) async {
      loading = Loading.initial;
      _emitUpdatedState(emit);

      await _loadData(emit);

      if (model != null) {
        await sharedStorage.addViewedId(startupId);
      }

      loading = null;
      _emitUpdatedState(emit);
    });

    on<MainDetailsOnPullToRefresh>((event, emit) async {
      loading = Loading.refresh;
      _emitUpdatedState(emit);

      await _loadData(emit);

      loading = null;
      _emitUpdatedState(emit);
    });

    on<MainDetailsOnFavoriteTapped>((event, emit) async {
      if (model == null) return;

      if (model!.isFavorite) {
        await mainService.removeFavoriteId(startupId);
      } else {
        await mainService.addFavoriteId(startupId);
      }

      model = model!.copyWith(isFavorite: !model!.isFavorite);
      _emitUpdatedState(emit);
    });
  }

  Future<void> _loadData(Emitter<MainDetailsState> emit) async {
    var favouriteIds = <String>[];
    var getFavoriteIdsResponse = await mainService.getFavoriteIds();
    getFavoriteIdsResponse.fold(
      (l) {
        _emitErrorState(emit, l.message);
      },
      (r) {
        favouriteIds = r ?? [];
      },
    );

    final response = await mainService.getStartupDetails(startupId);
    response.fold(
      (l) {
        _emitErrorState(emit, l.message);
      },
      (r) {
        if (r != null) {
          model = r.copyWith(isFavorite: favouriteIds.contains(r.id));
        }
      },
    );
  }

  _emitUpdatedState(Emitter<MainDetailsState> emit) {
    emit(MainDetailsUpdated(loading: loading, model: model));
  }

  _emitErrorState(Emitter<MainDetailsState> emit, String error) {
    emit(MainDetailsError(error: error, loading: loading, model: model));
  }
}
