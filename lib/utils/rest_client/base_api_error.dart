import 'dart:convert';

class BaseApiError {
  String? code;
  String? message;
  dynamic details;
  Data? data;
  dynamic validationErrors;

  BaseApiError({
    this.code,
    this.message,
    this.details,
    this.data,
    this.validationErrors,
  });

  factory BaseApiError.fromRawJson(String str) =>
      BaseApiError.fromJson(json.decode(str));

  factory BaseApiError.fromJson(Map<String, dynamic> json) => BaseApiError(
        code: json["error"]["code"] is String ? json["error"]["code"] : null,
        message: json["error"]["message"],
        details: json["error"]["details"],
        data: json["error"]["data"] == null
            ? null
            : Data.fromJson(json["error"]["data"]),
        validationErrors: json["error"]["validationErrors"],
      );
}

class Data {
  final Map<String, dynamic>? values;

  Data({this.values});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        values: json,
      );
}
