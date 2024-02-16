import 'package:injector/injector.dart';
import 'package:ioc_demo/data/network/api/user_api.dart';
import 'package:ioc_demo/domain/login/login_interactor.dart';

class DomainModule {
  static LoginInteractor createLoginInteractor(Injector injector) =>
      LoginInteractor(userApiClient: injector.get<UserApiClient>());
}
