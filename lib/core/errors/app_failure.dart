enum FailureType {
  network,
  timeout,
  configuration,
  server,
  parsing,
  storage,
  unknown,
}

class AppFailure {
  const AppFailure(this.type);

  final FailureType type;
}
