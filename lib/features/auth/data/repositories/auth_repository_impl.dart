import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:fpdart/fpdart.dart';
import 'package:raptor/core/errors/exceptions.dart';
import 'package:raptor/core/errors/failures.dart';
import 'package:raptor/features/auth/data/datasources/auth_firebase_data_source.dart';
import 'package:raptor/features/auth/domain/entity/user.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return await _returnUser(() async => remoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return await _returnUser(() async => remoteDataSource.signUpWithEmailPassword(
        email: email, password: password, name: name));
  }

  Future<Either<Failure, User>> _returnUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }  on fire.FirebaseAuthException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
