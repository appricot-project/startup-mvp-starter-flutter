import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  SharedStorage shared;

  final double duration;
  final List<String> assets;
  int currentPage;

  double _progress = 0;
  Timer? _timer;
  bool _isFirstStartTimer = true;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  OnboardingBloc({
    required this.shared,
    required this.assets,
    this.currentPage = 0,
    required this.duration,
  }) : super(
         OnboardingInitial(
           assets: assets,
           currentPage: currentPage,
           progress: 0,
           isFirstStartTimer: true,
         ),
       ) {
    on<OnboardingOnAppear>((event, emit) async {
      await shared.setShowOnboarding();
      emit(
        OnboardingUpdated(
          assets: assets,
          currentPage: currentPage,
          progress: _progress,
          isFirstStartTimer: _isFirstStartTimer,
        ),
      );
    });
    on<OnboardingOnSkip>((event, emit) {
      _timer?.cancel();
      emit(
        OnboardingSkip(
          assets: assets,
          currentPage: currentPage,
          progress: _progress,
          isFirstStartTimer: _isFirstStartTimer,
        ),
      );
    });
    on<OnboardingOnReturn>((event, emit) {
      emit(
        OnboardingUpdated(
          assets: assets,
          currentPage: currentPage,
          progress: _progress,
          isFirstStartTimer: _isFirstStartTimer,
        ),
      );
    });
    on<OnboardingOnTimerTicked>((event, emit) {
      emit(
        OnboardingUpdated(
          assets: assets,
          currentPage: currentPage,
          progress: _progress,
          isFirstStartTimer: _isFirstStartTimer,
        ),
      );
    });
    on<OnboardingOnChangedCurrentPage>((event, emit) {});
  }
}
