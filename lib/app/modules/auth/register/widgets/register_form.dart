part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  RegisterController get controller => Modular.get<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            controller: _loginEC,
            labelText: 'Login',
            validator: Validatorless.multiple([
              Validatorless.required('Campo obrigatório'),
              Validatorless.email('E-mail inválido')
            ]),
          ),
          SizedBox(height: 20.h),
          CuidapetTextFormField(
            controller: _passwordEC,
            labelText: 'Senha',
            validator: Validatorless.multiple([
              Validatorless.required('Campo obrigatório'),
              Validatorless.min(6, 'Senha precisa ter pelo menos 6 caracteres')
            ]),
            obscureText: true,
          ),
          SizedBox(height: 20.h),
          CuidapetTextFormField(
            labelText: 'Confirma Senha',
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required('Campo obrigatório'),
              Validatorless.min(6, 'Senha precisa ter pelo menos 6 caracteres'),
              Validatorless.compare(
                  _passwordEC, 'Senha e confima senha não são iguais'),
            ]),
          ),
          SizedBox(height: 20.h),
          CuidapetDefaultButton(
            onPressed: () {
              final isValid = _formKey.currentState?.validate() ?? false;
              if (isValid) {
                controller.register(
                    email: _loginEC.text, password: _passwordEC.text);
              }
            },
            label: 'Cadastrar',
          )
        ],
      ),
    );
  }
}
