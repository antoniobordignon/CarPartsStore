import 'package:basic_app/data/services/api_constants.dart';
import 'package:basic_app/domain/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:basic_app/util/extensions/num_extension.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class _ApiService implements IApiService {
  User user;

  Map<String, String> authHeaders() {
    final defaultheaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Database': ApiConstants.database,
      'UserName': user.login,
      'Password': user.password,
    };
    return defaultheaders;
  }

  _ApiService(this.user);

  final http.Client client = http.Client();
  final Logger logger = Logger(
    printer: PrettyPrinter(
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );
  Duration timeout = const Duration(seconds: 15);

  @override
  Future<HttpResponseModel> get(String path, {Map<String, String>? headers, Map<String, String>? queryParams, Duration? timeOut}) async {
    try {
      var uri = Uri.http(ApiConstants.host, path, queryParams);
      headers ??= {};
      headers.addAll(authHeaders());
      logger.i('GET request to $ApiConstants.host$path with headers: $headers and queryParams: $queryParams');
      final response = await client.get(uri, headers: headers).timeout(timeout);
      return _toCustomResponse(response);
    } on TimeoutException {
      return HttpResponseModel(
        statusCode: 408,
        headers: {},
        body: null,
        error: 'Request Timeout',
      );
    } on SocketException catch (e) {
      return HttpResponseModel(
        statusCode: 503,
        headers: {},
        body: null,
        error: e.message,
      );
    } on http.ClientException catch (e) {
      return HttpResponseModel(
        statusCode: 400,
        headers: {},
        body: null,
        error: e.message,
      );
    } on Exception catch (e) {
      return HttpResponseModel(
        statusCode: 400,
        headers: {},
        body: null,
        error: 'Bad request: ${e.toString()}',
      );
    }
  }

  @override
  Future<HttpResponseModel> post(String path, {Map<String, String>? headers, dynamic body, Map<String, String>? queryParams, Duration? timeOut}) async {
    try {
      headers ??= {};
      headers.addAll(authHeaders());
      final uri = Uri.http(ApiConstants.host, path, queryParams);
      final response = await client
          .post(
            uri,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(timeout);
      return _toCustomResponse(response);
    } on TimeoutException {
      return HttpResponseModel(
        statusCode: 408,
        headers: {},
        body: null,
        error: 'Request Timeout',
      );
    } on SocketException catch (e) {
      return HttpResponseModel(
        statusCode: 503,
        headers: {},
        body: null,
        error: e.message,
      );
    } on http.ClientException catch (e) {
      return HttpResponseModel(
        statusCode: 400,
        headers: {},
        body: null,
        error: e.message,
      );
    }
  }

  @override
  Future<HttpResponseModel> put(String path, {Map<String, String>? headers, dynamic body, Map<String, String>? queryParams, Duration? timeOut}) async {
    try {
      final uri = Uri.http(ApiConstants.host, path, queryParams);
      headers ??= {};
      headers.addAll(authHeaders());
      final response = await client
          .put(
            uri,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(timeout);
      return _toCustomResponse(response);
    } on TimeoutException {
      return HttpResponseModel(
        statusCode: 408,
        headers: {},
        body: null,
        error: 'Request Timeout',
      );
    } on SocketException catch (e) {
      return HttpResponseModel(
        statusCode: 503,
        headers: {},
        body: null,
        error: e.message,
      );
    } on http.ClientException catch (e) {
      return HttpResponseModel(
        statusCode: 400,
        headers: {},
        body: null,
        error: e.message,
      );
    }
  }

  @override
  Future<HttpResponseModel> delete(String path, {Map<String, String>? headers, Map<String, String>? queryParams, Duration? timeOut}) async {
    try {
      final uri = Uri.http(ApiConstants.host, path, queryParams);
      headers ??= {};
      headers.addAll(authHeaders());
      final response = await client
          .delete(
            uri,
            headers: headers,
          )
          .timeout(timeout);
      return _toCustomResponse(response);
    } on TimeoutException {
      return HttpResponseModel(
        statusCode: 408,
        headers: {},
        body: null,
        error: 'Request Timeout',
      );
    } on SocketException catch (e) {
      return HttpResponseModel(
        statusCode: 503,
        headers: {},
        body: null,
        error: e.message,
      );
    } on http.ClientException catch (e) {
      return HttpResponseModel(
        statusCode: 400,
        headers: {},
        body: null,
        error: e.message,
      );
    }
  }

  HttpResponseModel _toCustomResponse(http.Response response) {
    String? error;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      error = 'Request failed with status: ${response.statusCode}';
    }
    return HttpResponseModel(
      statusCode: response.statusCode,
      headers: response.headers,
      body: response.body,
      error: error,
    );
  }
}

class HttpResponseModel {
  @override
  String toString() {
    return 'HttpResponseModel(statusCode: $statusCode, headers: $headers, body: $body, error: $error)';
  }

  final int statusCode;
  final Map<String, String> headers;
  final String? body;
  String? _error;

  bool get hasSucess => statusCode.between(200, 299, inclusive: true);

  bool get canBeParsed => body != null && (body?.isNotEmpty == true);

  String? get error {
    if (_error != null) {
      return _error;
    }
    if (_error == null && !hasSucess) {
      return statusMessage;
    }

    return null;
  }

  HttpResponseModel({
    required this.statusCode,
    required this.headers,
    required this.body,
    String? error,
  });

  String get statusMessage {
    return body ?? '';
    // switch (statusCode) {
    //   case 200:
    //     return 'OK';
    //   case 201:
    //     return 'Criado';
    //   case 204:
    //     return 'Sem Conteúdo';
    //   case 400:
    //     return 'Requisição Inválida';
    //   case 401:
    //     return 'Não Autorizado';
    //   case 403:
    //     return 'Proibido';
    //   case 404:
    //     return 'Não Encontrado';
    //   case 408:
    //     return 'Tempo de Requisição Esgotado';
    //   case 500:
    //     return 'Erro Interno do Servidor';
    //   case 502:
    //     return 'Gateway Inválido';
    //   case 503:
    //     return 'Serviço indisponível. Verifique sua conexão e tente novamente mais tarde.';
    //   default:
    //     return 'Status Desconhecido';
    // }
  }
}

abstract class IApiService {
  factory IApiService(User user) {
    return _ApiService(user);
  }

  Future<HttpResponseModel> get(String path, {Map<String, String>? queryParams, Map<String, String>? headers, Duration? timeOut});
  Future<HttpResponseModel> post(String path, {Map<String, String>? headers, dynamic body, Map<String, String>? queryParams, Duration? timeOut});
  Future<HttpResponseModel> put(String path, {Map<String, String>? headers, dynamic body, Map<String, String>? queryParams, Duration? timeOut});
  Future<HttpResponseModel> delete(String path, {Map<String, String>? headers, Map<String, String>? queryParams, Duration? timeOut});
}
