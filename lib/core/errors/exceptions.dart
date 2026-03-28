import 'package:equatable/equatable.dart';
import 'package:mstech/core/errors/failures.dart';

class ServerException extends Equatable implements Failure {
  const ServerException({required this.message});

  @override
  final String message;

  @override
  List<Object?> get props => [message];
}

class APIException extends ServerException {
  const APIException({required super.message, required this.statusCode});

  final int statusCode;
}

class CacheException extends ServerException {
  const CacheException({required super.message});
}
