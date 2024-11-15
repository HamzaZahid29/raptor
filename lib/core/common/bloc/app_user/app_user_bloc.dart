import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc() : super(AppUserInitial()) {
    on<AppUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
