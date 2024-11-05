import 'package:fpdart/fpdart.dart';
import 'package:raptor/core/errors/failures.dart';

abstract interface class UseCase<SuccessType, Params>{
  Future<Either<Failure, SuccessType>> call(Params params);
}
