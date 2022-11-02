extension NullableExtension<T> on T? {
  bool get isNull => this == null;
}
