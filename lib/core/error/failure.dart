sealed class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

final class ParsingFailure extends Failure {
  const ParsingFailure(String message) : super(message);
}

final class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}
