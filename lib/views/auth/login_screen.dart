import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:test/services/api/auth_api.dart';
import 'package:test/services/bloc/login_bloc.dart';

import 'package:test/utils/colors.dart';
import 'package:test/widgets/appbar_back_button.dart';
import 'package:test/widgets/button_app.dart';
import 'package:test/widgets/gradient_background.dart';
import 'package:test/widgets/gradient_componentdart';
import 'package:test/widgets/snackbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthApi()),
      child: GradientBackground(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const AppbarBackButton()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    Navigator.pushReplacementNamed(context, '/about');
                  }
                  if (state.isFailure) {
                    SnackBarApp.danger(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return FormBuilder(
                    child: Column(children: [
                      FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.email()]),
                        name: "email",
                        onChanged: (value) => context.read<LoginBloc>().add(EmailChangedEvent(value ?? '')),
                        cursorColor: ColorApp.primary,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: "Enter Username/Email",
                          hintStyle: TextStyle(color: ColorApp.hintWhite),
                          filled: true,
                          fillColor: ColorApp.faintWhite,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        name: "password",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.minLength(8)]),
                        onChanged: (value) => context.read<LoginBloc>().add(PasswordChangedEvent(value ?? '')),
                        cursorColor: ColorApp.primary,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        obscureText: !state.isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => context.read<LoginBloc>().add(TogglePasswordVisibilityEvent()),
                            child: Icon(state.isPasswordVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash, color: Colors.white),
                          ),
                          hintText: "Enter Password",
                          hintStyle: const TextStyle(color: ColorApp.hintWhite),
                          filled: true,
                          fillColor: ColorApp.faintWhite,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ButtonApp(
                          onTap: () => {context.read<LoginBloc>().add(SubmitLoginEvent())},
                          title: "Login",
                          disabled: state.isLoading || state.hasInputError),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No account? ", style: TextStyle(color: Colors.white, fontSize: 12)),
                          InkWell(
                            onTap: () => Navigator.pushReplacementNamed(context, '/register'),
                            child: const GradientText(
                              "Register here",
                              style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                              colors: ColorApp.goldenGradientColorList,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  );
                },
              ),
            ]),
          ),
        ),
      )),
    );
  }
}
