import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key, required AuthStore authStore})
      : _authStore = authStore;
  final AuthStore _authStore;
  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  void initState() {
    reaction<UserModel?>((_) => widget._authStore.userLogged, (user) {
      if (user != null && user.email.isNotEmpty) {
        Modular.to.navigate('/home');
      } else {
        Modular.to.navigate('/auth/login');
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._authStore.loadUserLogged();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/logo.png',
        width: 162.w,
        height: 130.h,
        fit: BoxFit.contain,
      )),
    );
  }
}
