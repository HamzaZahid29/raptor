import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raptor/core/usecase/usecase.dart';
import 'package:raptor/features/auth/domain/usecases/current_user.dart';
import 'package:raptor/features/auth/domain/usecases/user_login.dart';
import 'package:raptor/features/auth/domain/usecases/user_sign_up.dart';

import '../../../../core/common/entity/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthlogin);
    on<AuthCurrentUser>(_onAuthCurrentUser);
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
    final response = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    response.fold((l) => emit(AuthFailure(messege: l.message)),
        (user) => emit(AuthSuccess(user: user)));
  }

  void _onAuthCurrentUser(
      AuthCurrentUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _currentUser(NoParams());
    response.fold((l) => emit(AuthFailure(messege: l.message)),
        (user) => emit(AuthSuccess(user: user)));
  }
}

// TODO:  test this properly
