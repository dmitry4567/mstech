import 'package:dartz/dartz.dart';
import 'package:mstech/core/errors/failures.dart';
import 'package:mstech/core/utils/typedefs.dart';

abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract class UseCaseWithoutFuture<T, Params> {
  Either<Failure, T> call(Params params);
}

class NoParams {}

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call({required Params params});
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
