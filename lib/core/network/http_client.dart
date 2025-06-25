import 'dart:async';
import 'package:http/http.dart' as http;
import '../error/failure.dart';
import '../utils/logger.dart';

class AppHttpClient {
  final http.Client _client;

  AppHttpClient({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> get(
      Uri uri, {
        Map<String, String>? headers,
        Duration timeout = const Duration(seconds: 10),
      }) async {
    AppLogger.debug('GET $uri');

    try {
      final response = await _client.get(uri, headers: headers).timeout(timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw NetworkFailure('Request failed with status: ${response.statusCode}');
      }
    } on http.ClientException catch (e, st) {
      AppLogger.error(e, stackTrace: st);
      throw NetworkFailure('Client error: ${e.message}');
    } on TimeoutException catch (e, st) {
      AppLogger.error(e, stackTrace: st);
      throw NetworkFailure('Request timeout');
    } catch (e, st) {
      AppLogger.error(e, stackTrace: st);
      throw UnknownFailure(e.toString());
    }
  }
}
