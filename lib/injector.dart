import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:injector/injector.dart';
import 'package:ioc_demo/data/network/api/user_api.dart';
import 'package:ioc_demo/domain/login/login_interactor.dart';
import 'package:ioc_demo/modules/bloc_module.dart';
import 'package:ioc_demo/modules/domain_module.dart';
import 'package:ioc_demo/modules/network_module.dart';
import 'package:ioc_demo/presentation/login/login_bloc/bloc.dart';

class IOC {
  IOC.appScope() : parent = null {
    _initDependencies();
  }

  IOC.appScopeTest({void Function(Injector injector)? builder})
      : parent = null {
    if (builder != null) {
      builder(injector);
    }
  }

  @visibleForTesting
  final Injector injector = Injector();
  final List<DisposableDependency> _disposables = <DisposableDependency>[];
  final IOC? parent;

  void _initDependencies() {
    _registerSingleton<Dio>(NetworkModule.createDio);

    _registerDependency<LoginBloc>(BlocModule.createLoginBloc);

    _registerSingleton<UserApiClient>(NetworkModule.createUserApiClient);

    _registerDependency<LoginInteractor>(DomainModule.createLoginInteractor);
  }

  void _registerSingleton<T>(Builder<T> builder,
      {bool override = false, String dependencyName = ''}) {
    injector.registerSingleton<T>(() {
      final T instance = builder(injector);
      if (instance is DisposableDependency) {
        _disposables.add(instance);
      }
      return instance;
    }, override: override, dependencyName: dependencyName);
  }

  // ignore: unused_element
  void _registerDependency<T>(Builder<T> builder,
      {bool override = false, String dependencyName = ''}) {
    injector.registerDependency<T>(() {
      final T instance = builder(injector);
      if (instance is DisposableDependency) {
        _disposables.add(instance);
      }
      return instance;
    }, override: override, dependencyName: dependencyName);
  }

  T getDependency<T>({String dependencyName = ''}) {
    try {
      if (exists<T>()) {
        return injector.get<T>(dependencyName: dependencyName);
      } else if (parent?.exists() ?? false) {
        return parent!.getDependency<T>(dependencyName: dependencyName);
      } else {
        throw 'Type not defined ${T.toString()}';
      }
    } catch (e) {
      Fimber.e('', ex: e);
      throw 'Type not defined ${T.toString()}';
    }
  }

  bool exists<T>({String dependencyName = ''}) {
    return injector.exists<T>(dependencyName: dependencyName);
  }

  void dispose() {
    for (final DisposableDependency disposable in _disposables) {
      disposable.dispose();
    }
  }
}

typedef Builder<T> = T Function(Injector injector);

// ignore: one_member_abstracts
abstract class DisposableDependency {
  void dispose();
}
