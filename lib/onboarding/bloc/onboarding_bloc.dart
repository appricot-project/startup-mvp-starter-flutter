import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
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
    on<OnboardingOnAppear>((event, emit) {});
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
    on<OnboardingOnReturn>((event, emit) {});
    on<OnboardingOnTimerTicked>((event, emit) {});
    on<OnboardingOnChangedCurrentPage>((event, emit) {});
  }
}
