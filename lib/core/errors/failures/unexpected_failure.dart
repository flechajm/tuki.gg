import 'failure.dart';

class UnexpectedFailure extends Failure {
  UnexpectedFailure()
      : super(
          code: 500,
          message: "Unexpected error",
        );
}
