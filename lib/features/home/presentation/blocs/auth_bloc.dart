import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoginRequested) {
      yield AuthLoading();
      try {
        await Future.delayed(const Duration(seconds: 2));

        // In a real app, replace this with your authentication logic
        if (event.email == "test@example.com" && event.password == "password") {
          yield AuthAuthenticated("userId123");
        } else {
          yield AuthError("Invalid email or password.");
        }
      } catch (e) {
        yield AuthError("An error occurred. Please try again.");
      }
    }

    // Handle other events like logout if needed
  }
}
