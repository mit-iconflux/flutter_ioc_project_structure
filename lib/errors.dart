import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String mapError(BuildContext context, dynamic e) {
  if (e is AppErrors) {
    switch (e) {
      case AppErrors.serviceGatewayNotFound:
        return 'serviceGatewayNotFound';
      case AppErrors.serviceNotFound:
        return 'serviceNotFound';
      case AppErrors.serviceUrlIsEmpty:
        return 'serviceUrlIsEmpty';
    }
  } else if (e is DioException) {
    return _mapDioError(e) ?? 'Network error';
  } else if (e is PlatformException) {
    return e.message ?? 'Unhandled error';
  } else if (e is SocketException) {
    return 'Network error';
  }
  return e.toString();
}

String? _mapDioError(DioException error) {
  final Map<String, dynamic> responseData = error.response?.data;
  try {
    final ApiError apiError = ApiError.fromMap(responseData);
    if (apiError.message != null) {
      return apiError.message;
    } else {
      return 'Network error';
    }
  } catch (e) {
    return 'Network error';
  }
}

enum AppErrors {
  serviceGatewayNotFound,
  serviceNotFound,
  serviceUrlIsEmpty,
}

class ApiError {
  ApiError(this.code, this.error, this.message, this.errorId);

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      map['statusCode'] as int,
      map['error'] as String?,
      map['message'] as String?,
      map['error_id'] as String?,
    );
  }

  final int code;
  final String? error;
  final String? message;
  final String? errorId;
}
