class NumberRepository {
  Stream<List<int>> get getNumberStream {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => List<int>.generate(x + 1, (index) => index + 1),
    ).take(10);
  }
}
