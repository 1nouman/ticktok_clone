import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ticktok_proj/core/entities/user.dart';
import 'package:ticktok_proj/features/auth/domain/usecases/login_usecase.dart';
import 'package:ticktok_proj/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;

  final SignupUsecase _signupUsecase;
  AuthBloc(
      {required LoginUsecase loginuc, required SignupUsecase signupUsecase})
      : _loginUsecase = loginuc,
        _signupUsecase = signupUsecase,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<LoginEvent>((event, emit) async {
      final res =
          await _loginUsecase.call(LoginParams(event.email, event.password));
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<SignUpEvent>((event, emit) async {
      final res = await _signupUsecase.call(
          SignUpParams(event.email, event.name, event.password, event.image));
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });
  }
}
