part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {
  const _LoginRegisterButtons();
  LoginController get controller => Modular.get<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        RoundedButtonWithIcon(
          width: 170.w,
          color: const Color(0xff4267b3),
          onTap: () {},
          icon: Icons.facebook,
          title: 'Facebook',
        ),
        RoundedButtonWithIcon(
          width: 170.w,
          color: const Color(0xffe15031),
          onTap: () => controller.socialLogin(SocialLoginType.google),
          icon: Icons.g_mobiledata_sharp,
          title: 'Google',
        ),
        RoundedButtonWithIcon(
          width: 170.w,
          color: context.primaryColorDark,
          onTap: () {
            Navigator.of(context).pushNamed('/auth/register');
          },
          icon: Icons.mail,
          title: 'Cadastre-se',
        ),
      ],
    );
  }
}
