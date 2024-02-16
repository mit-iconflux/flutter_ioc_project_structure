import 'package:dio/dio.dart';
import 'package:injector/injector.dart';
import 'package:ioc_demo/data/network/api/user_api.dart';
import 'package:ioc_demo/data/network/dio_factory.dart';

class NetworkModule {
  static Dio createDio(Injector injector) {
    return DioFactory.create();
  }

  static UserApiClient createUserApiClient(Injector injector) {
    return UserApiClient(injector.get<Dio>());
  }
}
