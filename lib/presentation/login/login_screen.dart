import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioc_demo/injector.dart';
import 'package:ioc_demo/presentation/login/login_bloc/bloc.dart';
import 'package:ioc_demo/presentation/login/widgets/login_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<IOC>(
      builder: (BuildContext context, IOC ioc, Widget? child) {
        return BlocProvider<LoginBloc>(
          create: (_) => ioc.getDependency<LoginBloc>(),
          child: LoginWidget(
            loginBloc: ioc.getDependency<LoginBloc>(),
          ),
        );
      },
    );
  }
}
