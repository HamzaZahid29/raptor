import 'package:fpdart/src/either.dart';
import 'package:raptor/core/errors/failures.dart';
import 'package:raptor/core/usecase/usecase.dart';
import 'package:raptor/features/auth/domain/entity/user.dart';
import 'package:raptor/features/auth/domain/repository/auth_repository.dart';


class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository;


  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await authRepository.currentUser();
  }

}