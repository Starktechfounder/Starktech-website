import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';

class ErrorHandler {
  static Middleware middleware() {
    return (Handler innerHandler) {
      return (Request request) async {
        try {
          return await innerHandler(request);
        } catch (error, stackTrace) {
          print('Error: $error');
          print('Stack trace: $stackTrace');
          
          return _handleError(error);
        }
      };
    };
  }

  static Response _handleError(dynamic error) {
    Map<String, dynamic> errorResponse;
    int statusCode;

    if (error is ValidationException) {
      statusCode = 400;
      errorResponse = {
        'status': 'error',
        'message': error.message,
        'errors': error.errors,
      };
    } else if (error is DatabaseException) {
      statusCode = 500;
      errorResponse = {
        'status': 'error',
        'message': 'Database error occurred',
      };
    } else if (error is HttpException) {
      statusCode = error.statusCode;
      errorResponse = {
        'status': 'error',
        'message': error.message,
      };
    } else {
      statusCode = 500;
      errorResponse = {
        'status': 'error',
        'message': 'An unexpected error occurred',
      };
    }

    return Response(
      statusCode,
      body: jsonEncode(errorResponse),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String> errors;

  ValidationException(this.message, this.errors);

  @override
  String toString() => 'ValidationException: $message';
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);

  @override
  String toString() => 'HttpException: $statusCode - $message';
}
