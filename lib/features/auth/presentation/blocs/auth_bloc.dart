import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raptor/features/auth/domain/entity/user.dart';
import 'package:raptor/features/auth/domain/usecases/user_login.dart';
import 'package:raptor/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthlogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));
    response.fold((l) => emit(AuthFailure(messege: l.message)),
        (user) => emit(AuthSuccess(user: user)));
  }
  void _onAuthlogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(UserLoginParams(
        email: event.email, password: event.password));
    response.fold((l) => emit(AuthFailure(messege: l.message)),
        (user) => emit(AuthSuccess(user: user)));
  }
}

// TODO:  test this properly
