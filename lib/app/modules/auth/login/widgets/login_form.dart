part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            labelText: 'Login',
          ),
          SizedBox(height: 20.h),
          CuidapetTextFormField(
            labelText: 'Senha',
            obscureText: true,
          ),
          SizedBox(height: 20.h),
          CuidapetDefaultButton(
            onPressed: () {},
            label: 'Entrar',
          ),
        ],
      ),
    );
  }
}
