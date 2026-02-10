import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:startup_mvp_starter_flutter/utils/app_config.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/debug_print_long.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/base_api_error.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/token_response_dto.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class RestClient {
  IOClient _client;
  final SharedStorage shared;
  final AppConfig appConfig;

  RestClient({required this.shared, required this.appConfig})
    : _client = IOClient(
        HttpClient()
          ..idleTimeout = const Duration(seconds: 10)
          ..connectionTimeout = const Duration(seconds: 10)
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true,
      );
  RestClient.withBaseUrl({required this.shared, required this.appConfig})
    : _client = IOClient(
        HttpClient()
          ..connectionTimeout = const Duration(seconds: 10)
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true,
      );

  Future<Map<String, String>> _defaultHeaders() async {
    Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'x-mz-client-origin': Platform.isIOS ? 'ios-app' : 'android-app',
    };

    final token = await shared.getToken();
    if (token != null && token.isNotEmpty) {
      _headers['Authorization'] = 'Bearer $token';
    }
    return _headers;
  }

  Future<dynamic> _sendRequest(
    String method,
    String path, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse('${appConfig.baseUrl}$path');
    final newHeaders = headers ?? await _defaultHeaders();
    headers = newHeaders;

    final request = http.Request(method, uri)..headers.addAll(newHeaders);
    if (body != null) {
      if (body is List) {
        request.body =
            '${body.map((element) => json.encode(element)).toList()}';
      } else {
        request.body = json.encode(body);
      }
    }
    final stopwatch = Stopwatch()..start();
    try {
      final stopwatch = Stopwatch()..start();
      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      _logRequestResponse(
        request,
        response,
        body: body != null ? json.encode(body) : '',
        duration: stopwatch.elapsed,
      );

      if (response.statusCode == 401) {
        if (await _refreshToken()) {
          return _sendRequest(
            method,
            path,
            headers: await _defaultHeaders(),
            body: body,
          );
        } else {
          if ((locator<AuthCubit>().state)) {
            locator<AuthCubit>().logout();
          }

          throw const ApiException('Unauthorized, token refresh failed');
        }
      } else {
        return await _handleResponse(response, body: json.encode(body));
      }
    } on TimeoutException {
      final fakeResponse = http.Response('', 408);
      _logRequestResponse(
        request,
        fakeResponse,
        body: body != null ? json.encode(body) : '',
        duration: stopwatch.elapsed,
      );
      throw const ApiException('Нет подключения к Интернету');
    } on SocketException {
      final fakeResponse = http.Response('', 503);
      _logRequestResponse(
        request,
        fakeResponse,
        body: body != null ? json.encode(body) : '',
        duration: stopwatch.elapsed,
      );
      throw const ApiException('Нет подключения к Интернету');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      } else {
        throw ApiException(e.toString());
      }
    }
  }

  dynamic _handleResponse(http.Response response, {String body = ''}) async {
    if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      return utf8.decode(response.bodyBytes);
    } else if (response.statusCode == 400) {
      throw const ApiException('Bad Request');
    } else if (response.statusCode == 500) {
      throw const ApiException('Внутренняя ошибка сервера');
    } else {
      BaseApiError? baseApiError;
      if (response.body.isNotEmpty) {
        try {
          baseApiError = BaseApiError.fromRawJson(response.body);
        } catch (e) {
          debugPrint('Failed to parse error response: $e');
        }
      }
      throw ApiException(
        baseApiError?.message ??
            '${response.statusCode} ${response.reasonPhrase}',
        statusCode: response.statusCode,
        data: baseApiError,
      );
    }
  }

  void _logRequestResponse(
    http.Request request,
    http.Response response, {
    String body = '',
    Duration? duration,
  }) {
    debugPrintLongStr('''

╔═══════════════════════════════════════════════
║ REQUEST:  ${request.method} ${request.url}
║ Headers:  ${request.headers}
║ Body:     ${_formatBody(body)}
║-----------------------------------------------
║ RESPONSE  ${_statusDescription(response.statusCode)}
║ Headers:  ${response.headers}
║ Body:     ${_formatBody(utf8.decode(response.bodyBytes))}
║ Duration: ${duration != null ? '${duration.inMilliseconds} ms' : 'Unknown'} 
╚═══════════════════════════════════════════════
''');
  }

  String _formatBody(String body) {
    return body.isEmpty ? 'Empty' : body;
  }

  String _statusDescription(int code) {
    const statusDescriptions = {
      200: {'text': 'OK', 'emoji': '✅'},
      201: {'text': 'Created', 'emoji': '🆕'},
      204: {'text': 'No Content', 'emoji': '🔒'},
      400: {'text': 'Bad Request', 'emoji': '❌'},
      401: {'text': 'Unauthorized', 'emoji': '🚫'},
      403: {'text': 'Forbidden', 'emoji': '🔒'},
      404: {'text': 'Not Found', 'emoji': '🔍'},
      500: {'text': 'Internal Server Error', 'emoji': '💥'},
      502: {'text': 'Bad Gateway ', 'emoji': '🌩️'},
      503: {'text': 'Service Unavailable', 'emoji': '🚧'},
      504: {'text': 'Gateway Timeout', 'emoji': '⏳'},
    };

    final status = statusDescriptions[code];
    if (status != null) {
      return '${status['emoji']} $code ${status['text']}';
    } else {
      return '❓ $code';
    }
  }

  Future<bool> _refreshToken() async {
    final url = Uri.parse('${appConfig.baseUrl}${appConfig.refreshPath}');
    final body = {'refreshToken': await shared.getRefreshToken()};
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.Request('POST', url)
      ..headers.addAll(headers)
      ..body = json.encode(body);

    try {
      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      _logRequestResponse(request, response, body: json.encode(body));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var refreshTokenResponseDto = TokenResponseDto.fromRawJson(
          response.body,
        );
        if (refreshTokenResponseDto.accessToken != null &&
            refreshTokenResponseDto.refreshToken != null) {
          await locator<AuthCubit>().login();
          return true;
        }
      }
      return false;
    } on ApiException catch (e) {
      debugPrint('Refresh token failed: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Unexpected error during token refresh: $e');
      return false;
    }
  }

  Future<dynamic> get(String path, {Map<String, String>? headers}) {
    return _sendRequest('GET', path, headers: headers);
  }

  Future<dynamic> post(
    String path, {
    Map<String, String>? headers,
    dynamic body,
  }) {
    return _sendRequest('POST', path, headers: headers, body: body);
  }

  Future<dynamic> put(
    String path, {
    Map<String, String>? headers,
    dynamic body,
  }) {
    return _sendRequest('PUT', path, headers: headers, body: body);
  }

  Future<dynamic> delete(
    String path, {
    Map<String, String>? headers,
    dynamic body,
  }) {
    return _sendRequest('DELETE', path, headers: headers, body: body);
  }
}
