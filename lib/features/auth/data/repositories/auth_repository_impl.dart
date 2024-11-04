
import 'package:fpdart/fpdart.dart';
import 'package:raptor/core/errors/failures.dart';
import 'package:raptor/features/auth/data/datasources/auth_firebase_data_source.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  // final AuthFirebaseDataSource remoteDataSource;
  @override
  Future<Either<Failure, String>> loginWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({required String name, required String email, required String password}) {
    // TODO: implement signUpWithEmailPassword
    throw UnimplementedError();
  }
  
}