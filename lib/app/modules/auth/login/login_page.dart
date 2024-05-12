import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_text_form_field.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/widgets/or_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(height: 50.h),
          Image.asset(
            'assets/images/logo.png',
            width: 162.w,
            height: 126.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.h),
          const _LoginForm(),
          SizedBox(height: 20.h),
          const OrSeparator(),
          SizedBox(height: 20.h),
          const _LoginRegisterButtons(),
        ]),
      ),
    );
  }
}
