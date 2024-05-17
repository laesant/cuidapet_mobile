part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  LoginController get controller => Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            labelText: 'Login',
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required('Campo obrigatório'),
              Validatorless.email('E-mail inválido'),
            ]),
          ),
          SizedBox(height: 20.h),
          CuidapetTextFormField(
            controller: _passwordEC,
            labelText: 'Senha',
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required('Campo obrigatório'),
              Validatorless.min(6, 'Senha deve conter pelo menos 6 caracteres'),
            ]),
          ),
          SizedBox(height: 20.h),
          CuidapetDefaultButton(
            onPressed: () async {
              final isValid = _formKey.currentState?.validate() ?? false;
              if (isValid) {
                await controller.login(_loginEC.text, _passwordEC.text);
              }
            },
            label: 'Entrar',
          ),
        ],
      ),
    );
  }
}
