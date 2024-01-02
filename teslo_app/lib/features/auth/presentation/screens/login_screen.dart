import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:log_print/log_print.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/auth/presentation/providers/login_form_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: GeometricalBackground(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // Icon Banner
            const Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.white,
              size: 100,
            ),
            const SizedBox(height: 80),

            Container(
              height: size.height - 260, // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _LoginForm(),
            )
          ],
        ),
      ))),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
    LogPrint("user-> ${ref.read(authProvider).user}", type: LogPrintType.info);

      LogPrint("lg screen-> ${next.user?.fullName}", type: LogPrintType.info);

      if (next.errorMsg.isNotEmpty) {
        LogPrint("login-> ${next.errorMsg}", type: LogPrintType.warning);
        showSnackbar(context, next.errorMsg, Colors.red);
        return;
      } else if (next.authStatus == AuthStatus.auth) {
        LogPrint("login-> Bienvenido", type: LogPrintType.success);
        showSnackbar(context, "Bienvenido", Colors.green);
        return;
      }
      return;
    });

    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text('Login', style: textStyles.titleLarge),
          const SizedBox(height: 50),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,

            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            onFieldSubmitted: (_)=> ref.read(loginFormProvider.notifier).onFormSubmit(),
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Ingresar',
                buttonColor: Colors.black,
                onPressed: loginForm.isPosting ? null : ref.read(loginFormProvider.notifier).onFormSubmit,
              )),
              // Text(ref.read(authProvider).user!.token == null ? "Vacio" : ref.read(authProvider).user!.token),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                  onPressed: () {
                    //  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //  ScaffoldMessenger.of(context).showSnackBar(showSnackbar(context, "erropr"));
                    context.push('/register');
                  },
                  child: const Text('Crea una aquí'))
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  void showSnackbar(_, msg, bgColor) {
    final snack = SnackBar(
      content: Text(msg),
      backgroundColor: bgColor,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(_).hideCurrentSnackBar();
    ScaffoldMessenger.of(_).showSnackBar(snack);
  }
}
