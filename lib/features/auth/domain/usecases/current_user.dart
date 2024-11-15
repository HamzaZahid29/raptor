import 'package:fpdart/src/either.dart';
import 'package:raptor/core/errors/failures.dart';
import 'package:raptor/core/usecase/usecase.dart';
import 'package:raptor/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/common/entity/user.dart';


class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository;


  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await authRepository.currentUser();
  }

}