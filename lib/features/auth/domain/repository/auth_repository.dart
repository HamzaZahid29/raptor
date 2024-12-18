import 'package:fpdart/fpdart.dart';
import 'package:raptor/core/errors/failures.dart';

import '../../../../core/common/entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
