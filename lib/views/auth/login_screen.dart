import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test/services/bloc/password_visibility_bloc.dart';
import 'package:test/utils/colors.dart';
import 'package:test/widgets/appbar_back_button.dart';
import 'package:test/widgets/gradient_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordVisibilityBloc(),
      child: GradientBackground(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const AppbarBackButton()),
        body: Padding(
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
            FormBuilder(
              child: Column(children: [
                FormBuilderTextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  name: "email",
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
                BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityBlocState>(
                  builder: (context, state) {
                    return FormBuilderTextField(
                      textInputAction: TextInputAction.next,
                      name: "password",
                      cursorColor: ColorApp.primary,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      obscureText: state.isObscured,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            context.read<PasswordVisibilityBloc>().add(
                                  TogglePasswordVisibilityEvent(),
                                );
                          },
                          child: Icon(state.isObscured ? CupertinoIcons.eye : CupertinoIcons.eye_slash, color: Colors.white),
                        ),
                        hintText: "Enter Password",
                        hintStyle: const TextStyle(color: ColorApp.hintWhite),
                        filled: true,
                        fillColor: ColorApp.faintWhite,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    );
                  },
                ),
              ]),
            )
          ]),
        ),
      )),
    );
  }
}
