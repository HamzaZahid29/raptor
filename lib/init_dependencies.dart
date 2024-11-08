import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:raptor/features/auth/data/datasources/auth_firebase_data_source.dart';
import 'package:raptor/features/auth/domain/repository/auth_repository.dart';
import 'package:raptor/features/auth/domain/usecases/user_sign_up.dart';
import 'package:raptor/features/auth/presentation/blocs/auth_bloc.dart';

import 'features/auth/data/repositories/auth_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSourceImpl(
      serviceLocator<FirebaseAuth>(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator<AuthFirebaseDataSource>(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator<UserSignUp>()),
  );
}
