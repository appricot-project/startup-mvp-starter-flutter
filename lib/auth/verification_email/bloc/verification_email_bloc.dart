import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'dart:async';

import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

part 'verification_email_event.dart';
part 'verification_email_state.dart';

class VerificationEmailBloc
    extends Bloc<VerificationEmailEvent, VerificationEmailState> {
  final String gmail;
  final Duration expireIn;
  Loading? loading;

  Timer? timer;
  Duration time = Duration();
  String? codeError;

  VerificationEmailBloc({required this.expireIn, required this.gmail})
    : super(
        VerificationEmailInitial(
          loading: null,
          gmail: gmail,
          time: Duration.zero,
          codeError: null,
        ),
      ) {
    on<VerificationEmailOnAppear>((event, emit) {
      startTimer(expireIn.inSeconds);
      _updating(emit);
    });
    on<VerificationEmailOnClose>((event, emit) {
      timer?.cancel();
      emit(
        VerificationEmailClose(
          loading: loading,
          gmail: gmail,
          time: time,
          codeError: codeError,
        ),
      );
    });
    on<VerificationEmailOnBack>((event, emit) {
      timer?.cancel();
      emit(
        VerificationEmailBack(
          loading: loading,
          gmail: gmail,
          time: time,
          codeError: codeError,
        ),
      );
    });
    on<VerificationEmailOnTimerTicked>((event, emit) {
      _updating(emit);
    });
    on<VerificationEmailOnNewCode>((event, emit) async {
      if (time.inSeconds == 0) {
        loading = Loading.actionLoading;
        _updating(emit);
        await Future.delayed(Duration(seconds: 1));
        loading = null;
        _updating(emit);
      }
    });
    on<VerificationEmailOnCodeChanged>((event, emit) async {
      if (event.code.length == 4) {
        loading = Loading.actionLoading;
        _updating(emit);
        await Future.delayed(Duration(seconds: 1));
        loading = null;
        if (event.code == "1111") {
          await locator<AuthCubit>().login(refreshToken: '', accessToken: '');
          timer?.cancel();
          emit(
            VerificationEmailClose(
              loading: loading,
              gmail: gmail,
              time: time,
              codeError: codeError,
            ),
          );
        } else {
          codeError = 'error';
          _updating(emit);
        }
      } else {
        codeError = null;
        _updating(emit);
      }
    });
  }

  _updating(Emitter<VerificationEmailState> emit) {
    emit(
      VerificationEmailUpdating(
        loading: loading,
        gmail: gmail,
        time: time,
        codeError: codeError,
      ),
    );
  }

  void startTimer(int maxSeconds) {
    time = Duration(seconds: maxSeconds);
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (time.inSeconds == 0) {
        timer?.cancel();
      } else {
        time = Duration(seconds: time.inSeconds - 1);
      }
      add(VerificationEmailOnTimerTicked());
    });
  }
}
