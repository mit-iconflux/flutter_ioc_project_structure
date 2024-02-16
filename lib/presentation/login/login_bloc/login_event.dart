import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLoginEvent extends LoginEvent {
  const DoLoginEvent(
      {required this.username,
      required this.password,
      required this.authProviderId});

  final String username;
  final String password;
  final String authProviderId;

  @override
  List<Object> get props => <Object>[username, password, authProviderId];
}
