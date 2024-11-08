
import 'package:fpdart/fpdart.dart';
import 'package:raptor/core/errors/exceptions.dart';
import 'package:raptor/core/errors/failures.dart';
import 'package:raptor/features/auth/data/datasources/auth_firebase_data_source.dart';
import 'package:raptor/features/auth/data/models/user_model.dart';
import 'package:raptor/features/auth/domain/entity/user.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthFirebaseDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({required String name, required String email, required String password}) async{
    try{
      final userId = await remoteDataSource.signUpWithEmailPassword(email: email, password: password, name: name);
      return right(userId);
    }on ServerException catch (e){
      return left(Failure(e.message));
    }
  }
  
}