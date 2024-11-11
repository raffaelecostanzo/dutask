extension BoolExtension on bool? {
  bool? toggle() {
    return switch (this) {
      false => null,
      null => true,
      true => false,
    };
  }
}
