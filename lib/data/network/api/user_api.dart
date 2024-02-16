import 'package:dio/dio.dart';
import 'package:ioc_demo/config.dart';
import 'package:ioc_demo/data/login/requests/login_request.dart';
import 'package:ioc_demo/domain/login/model/login_model.dart';
import 'package:retrofit/http.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: Config.baseURl)
abstract class UserApiClient {
  factory UserApiClient(Dio dio) = _UserApiClient;

  @POST('v1/login/password')
  Future<LoginModel> doLogin(@Body() LoginRequest loginRequest);
}
