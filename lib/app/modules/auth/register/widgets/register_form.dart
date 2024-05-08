part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(labelText: 'Login'),
          SizedBox(height: 20.h),
          CuidapetTextFormField(
            labelText: 'Senha',
            obscureText: true,
          ),
          SizedBox(height: 20.h),
          CuidapetTextFormField(
            labelText: 'Confirma Senha',
            obscureText: true,
          ),
          SizedBox(height: 20.h),
          CuidapetDefaultButton(
            onPressed: () {},
            label: 'Cadastrar',
          )
        ],
      ),
    );
  }
}
