import 'package:dio/dio.dart';

import '../../error/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        const NetworkException('Connexion trop lente. Vérifiez votre réseau.'),
      DioExceptionType.connectionError =>
        const NetworkException('Pas de connexion internet.'),
      DioExceptionType.badResponse => _handleResponse(err),
      _ => const NetworkException('Erreur réseau inattendue.'),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        message: appException.toString(),
      ),
    );
  }

  Exception _handleResponse(DioException err) {
    final data = err.response?.data;
    final message = data is Map ? data['message'] as String? : null;

    return switch (err.response?.statusCode) {
      400 => ValidationException(message ?? 'Requête invalide'),
      401 => const UnauthorizedException(),
      403 => const ServerException('Accès refusé.', statusCode: 403),
      404 => NotFoundException(message ?? 'Ressource introuvable.'),
      422 => ValidationException(
          message ?? 'Données invalides.',
          fieldErrors: _parseFieldErrors(data),
        ),
      500 => const ServerException('Erreur serveur. Réessayez plus tard.', statusCode: 500),
      _ => ServerException(
          message ?? 'Erreur inattendue (${err.response?.statusCode})',
          statusCode: err.response?.statusCode,
        ),
    };
  }

  Map<String, List<String>>? _parseFieldErrors(dynamic data) {
    if (data is! Map) return null;
    final errors = data['errors'];
    if (errors is! Map) return null;
    return errors.map(
      (k, v) => MapEntry(k as String, (v as List).cast<String>()),
    );
  }
}
