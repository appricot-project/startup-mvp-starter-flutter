T? safeCast<T>(Map<String, dynamic> json, String key, {T? defaultValue}) {
  final value = json[key];
  if (value is T) {
    return value;
  }
  if (T == int && value is String) {
    return int.tryParse(value) as T?;
  }
  if (T == double && value is String) {
    return double.tryParse(value) as T?;
  }
  if (T == double && value is int) {
    return value.toDouble() as T?;
  }
  return defaultValue;
}

T? safeCastObject<T>(dynamic value, T Function(Map<String, dynamic>) fromJson) {
  if (value is Map<String, dynamic>) {
    return fromJson(value);
  }
  return null;
}
