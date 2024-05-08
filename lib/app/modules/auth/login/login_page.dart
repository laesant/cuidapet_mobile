import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_text_form_field.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(children: [
            CuidapetTextFormField(
              labelText: 'Login',
              obscureText: true,
            ),
            RoundedButtonWithIcon(
              width: 200,
              color: Colors.blue,
              onTap: () {},
              icon: Icons.facebook,
              title: 'Facebook',
            ),
            RoundedButtonWithIcon(
              width: 200,
              color: Colors.orange,
              onTap: () {},
              icon: Icons.g_mobiledata_sharp,
              title: 'Google',
            ),
          ]),
        ),
      ),
    );
  }
}
