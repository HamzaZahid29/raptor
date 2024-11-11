import 'package:raptor/core/errors/failures.dart';
import 'package:raptor/core/usecase/usecase.dart';
import 'package:raptor/features/auth/domain/entity/user.dart';
import 'package:raptor/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
class UserLogin implements UseCase<User, UserLoginParams>{
  final AuthRepository authRepository;


  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async{
    return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}
class UserLoginParams{
  final String email;
  final String password;

  UserLoginParams(this.email, this.password);
}