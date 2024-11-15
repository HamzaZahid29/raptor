part of 'app_user_bloc.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}
final class AppUserLoggedIn extends AppUserState {}
