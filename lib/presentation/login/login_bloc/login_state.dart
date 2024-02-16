import 'package:equatable/equatable.dart';

/// LoginState
abstract class LoginState extends Equatable {
  ///Default Constructor
  const LoginState();
}

/// Class InitialLoginState
class InitialLoginState extends LoginState {
  /// Default Constructor
  const InitialLoginState();

  @override
  List<Object> get props => <Object>[];
}

/// LoadingLoginState
class LoadingLoginState extends LoginState {
  /// Default Constructor
  const LoadingLoginState();

  @override
  List<Object> get props => <Object>[];
}

/// ErrorLoginState
class ErrorLoginState extends LoginState {
  /// Default Constructor
  const ErrorLoginState({this.error});

  /// error
  final dynamic error;

  @override
  List<Object> get props => <Object>[error];
}

/// SuccessLoginState
class SuccessLoginState extends LoginState {
  /// Used for login success event
  const SuccessLoginState({
    required this.authHeader,
  });

  /// basicAuth
  final String authHeader;

  @override
  List<Object> get props => <Object>[
        authHeader,
      ];
}
