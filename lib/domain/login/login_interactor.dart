import 'package:ioc_demo/data/login/requests/login_request.dart';
import 'package:ioc_demo/data/network/api/user_api.dart';
import 'package:ioc_demo/domain/login/model/login_model.dart';

class LoginInteractor {
  const LoginInteractor({required this.userApiClient});

  final UserApiClient userApiClient;

  Future<LoginModel> doLogin(
      {required String username,
      required String password,
      required String authProviderId}) async {
    LoginRequest loginRequest = LoginRequest(
        username: username, password: password, authProviderId: authProviderId);
    final LoginModel loginModel = await userApiClient.doLogin(loginRequest);
    return loginModel;
  }
}
