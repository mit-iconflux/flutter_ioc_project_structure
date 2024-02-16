import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioc_demo/domain/login/login_interactor.dart';
import 'package:ioc_demo/domain/login/model/login_model.dart';
import 'package:ioc_demo/presentation/login/login_bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginInteractor,
  }) : super(const InitialLoginState()) {
    on<DoLoginEvent>(_handleDoLogin);
  }

  LoginInteractor loginInteractor;

  Future<void> _handleDoLogin(
    DoLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoadingLoginState());
    try {
      final LoginModel loginModel = await loginInteractor.doLogin(
          username: event.username,
          password: event.password,
          authProviderId: event.authProviderId);

      emit(SuccessLoginState(authHeader: loginModel.accessToken));
    } catch (e) {
      emit(ErrorLoginState(error: e));
    }
  }
}
