import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioc_demo/errors.dart';
import 'package:ioc_demo/presentation/dashboard/dashboard_screen.dart';
import 'package:ioc_demo/presentation/login/login_bloc/bloc.dart';
import 'package:ioc_demo/presentation/utility/snack_bar_mixin.dart';

class LoginWidget extends StatelessWidget with SnackBarMixin {
  const LoginWidget({Key? key, required this.loginBloc}) : super(key: key);

  final LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (BuildContext context, LoginState state) {
          if (state is ErrorLoginState) {
            if (state.error != null) {
              showSnackBar(
                  message: mapError(context, state.error), context: context);
            }
          } else if (state is SuccessLoginState) {
            Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => const DashboardScreen(),
              ),
            );
          }
        },
        builder: (BuildContext context, LoginState state) {
          return Scaffold(
            appBar: AppBar(),
            body: state is LoadingLoginState
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.black87,
                  ))
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            loginBloc.add(
                              const DoLoginEvent(
                                password: 'Chris1234!',
                                authProviderId: 'internal:aax-zvolt',
                                username: 'christoph+43@autosense.ch',
                              ),
                            );
                          }),
                    ),
                  )),
          );
        });
  }
}
