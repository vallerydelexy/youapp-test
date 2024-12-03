import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:test/services/api/auth_api.dart';
import 'package:test/services/bloc/register_bloc.dart';

import 'package:test/utils/colors.dart';
import 'package:test/widgets/appbar_back_button.dart';
import 'package:test/widgets/button_app.dart';
import 'package:test/widgets/gradient_background.dart';
import 'package:test/widgets/gradient_componentdart';
import 'package:test/widgets/snackbar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(AuthApi()),
      child: GradientBackground(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const AppbarBackButton()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                    if (state.isSuccess) {
                      SnackBarApp.success(context, "Registration successful");
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                builder: (context, state) {
                  debugPrint('state: ${state.isFormValid}');
                  return FormBuilder(
                    child: Column(children: [
                      FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.email()]),
                        name: "email",
                        onChanged: (value) => context.read<RegisterBloc>().add(EmailChangedEvent(value ?? '')),
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
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: ColorApp.faintWhite,
                              border: Border.all(style: BorderStyle.none),
                            ),
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(text: state.emailValue),
                              cursorColor: ColorApp.primary,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: "Create username",
                                hintStyle: TextStyle(color: ColorApp.hintWhite),
                                filled: false,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        name: "password",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(8),
                              ]),
                        onChanged: (value) => context.read<RegisterBloc>().add(PasswordChangedEvent(value ?? '')),
                        cursorColor: ColorApp.primary,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        obscureText: !state.isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => context.read<RegisterBloc>().add(TogglePasswordVisibilityEvent()),
                            child: Icon(state.isPasswordVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash, color: Colors.white),
                          ),
                          hintText: "Create Password",
                          hintStyle: const TextStyle(color: ColorApp.hintWhite),
                          filled: true,
                          fillColor: ColorApp.faintWhite,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        name: "confirm password",
                        onChanged: (value) => context.read<RegisterBloc>().add(PasswordConfirmChangedEvent(value ?? '')),
                        validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(8),
                                (_) => state.isPasswordMatch ? null : 'Password does not match',
                              ]),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: ColorApp.primary,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        obscureText: !state.isPasswordConfirmVisible,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => context.read<RegisterBloc>().add(TogglePasswordConfirmVisibilityEvent()),
                            child: Icon(state.isPasswordConfirmVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash, color: Colors.white),
                          ),
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(color: ColorApp.hintWhite),
                          filled: true,
                          fillColor: ColorApp.faintWhite,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ButtonApp(onTap: () => {context.read<RegisterBloc>().add(SubmitRegisterEvent())}, title: "Register", disabled: state.isLoading || !state.isFormValid),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Have an account? ", style: TextStyle(color: Colors.white, fontSize: 12)),
                          InkWell(
                            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                            child: const GradientText(
                              "Login here",
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
