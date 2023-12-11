import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/blocs/register_cubit/register_cubit.dart';
import "package:form_app/widgets/inputs/inputs.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const FlutterLogo(
              size: 100,
            ),
            _RegisterForm(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}

class _RegisterForm extends StatefulWidget {
  _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormStateasd();
}

class _RegisterFormStateasd extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Map initialValues = {
  //   "name": "",
  //   "nacionality": "",
  //   "mail": "",
  //   "password": ""
  // };

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(children: [
              CustomTextFormField(
                label: "Full name",
                onChanged: (value) {
                  registerCubit.nameChanged(value);
                  _formKey.currentState?.validate();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value.trim().isEmpty) return 'Campo requerido';
                  if (value.length < 6) return 'Más de 6 letras';
                  return null;
                },
              ),
              CustomTextFormField(
                label: 'Correo electrónico',
                onChanged: (value) {
                  registerCubit.emailChanged(value);
                  _formKey.currentState?.validate();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value.trim().isEmpty) return 'Campo requerido';
                  final emailRegExp = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (!emailRegExp.hasMatch(value))
                    return 'No tiene formato de correo';

                  return null;
                },
              ),
              const SizedBox(height: 10),

              CustomTextFormField(
                label: 'Contraseña',
                obscureText: true,
                onChanged: (value) {
                  _formKey.currentState?.validate();
                  registerCubit.passwordChanged(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value.trim().isEmpty) return 'Campo requerido';
                  if (value.length < 6) return 'Más de 6 letras';
                  return null;
                },
              ),

              /// `CustomTextFormField` is a custom widget that extends the `TextFormField` widget
              /// provided by Flutter. It is used to create a text input field with custom styling and
              /// validation. It takes parameters such as `label`, `onChanged`, and `validator` to
              /// customize its behavior and appearance.
              // CustomTextFormField(
              //   label: "Nacionality",
              //   onChanged: (value) => initialValues["nacionality"] = value,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) return 'Campo requerido';
              //     if (value.trim().isEmpty) return 'Campo requerido';
              //     return null;
              //   },
              // ),
              // for (CustomTextFormField customInput in listInputs) customInput,
              ElevatedButton.icon(
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) return;
                    registerCubit.onSumbit();
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Send")),
            ])),
      ],
    );
  }
}

// List<CustomTextFormField> listInputs = [
//   const CustomTextFormField(label: "Nacionality"),
//   const CustomTextFormField(label: "Mail"),
//   const CustomTextFormField(
//     label: "Password",
//     obscureText: true,
//   ),
// ];
