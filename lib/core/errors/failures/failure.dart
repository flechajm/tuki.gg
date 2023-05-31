abstract class Failure {
  final int code;
  final String message;

  const Failure({
    required this.code,
    required this.message,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required int code,
    required String message,
  }) : super(
          code: code,
          message: message,
        );
}
