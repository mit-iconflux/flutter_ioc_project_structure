import 'package:injector/injector.dart';
import 'package:ioc_demo/domain/login/login_interactor.dart';
import 'package:ioc_demo/presentation/login/login_bloc/bloc.dart';

class BlocModule {
  static LoginBloc createLoginBloc(Injector injector) {
    return LoginBloc(
      loginInteractor: injector.get<LoginInteractor>(),
    );
  }
}
