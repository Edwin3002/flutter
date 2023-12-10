import 'package:flutter/material.dart';
import "package:form_app/widgets/inputs/inputs.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: const _RegisterView(),
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
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map initialValues = {
    "name": "",
    "nacionality": "",
    "mail": "",
    "password": ""
  };
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(children: [
              CustomTextFormField(
                label: "Full name",
                onChanged: (value) => initialValues["name"] = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value.trim().isEmpty) return 'Campo requerido';
                  if (value.length < 6) return 'Más de 6 letras';
                  return null;
                },
              ),
              CustomTextFormField(
                label: 'Correo electrónico',
                onChanged: (value) => initialValues["mail"] = value,
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
                onChanged: (value) => initialValues["password"] = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value.trim().isEmpty) return 'Campo requerido';
                  if (value.length < 6) return 'Más de 6 letras';
                  return null;
                },
              ),

              CustomTextFormField(
                label: "Nacionality",
                onChanged: (value) => initialValues["nacionality"] = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value.trim().isEmpty) return 'Campo requerido';
                   return null;
                },
              ),
              // for (CustomTextFormField customInput in listInputs) customInput,
              ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) return;
                    print(initialValues);
                  },
                  child: const Text("Send"))
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
