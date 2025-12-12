
import 'package:startup_mvp_starter_flutter/utils/rest_client/base_api_error.dart';

class ApiException implements Exception {
  final String message;
  final int statusCode;
  final BaseApiError? data;

  const ApiException(
    this.message, {
    this.statusCode = 0,
    this.data,
  });

  @override
  String toString() {
    return 'ApiException: statusCode - $statusCode; message - $message; data: $data';
  }
}
