import 'failure.dart';

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure()
      : super(
          code: 599,
          message: "No internet connection",
        );
}
