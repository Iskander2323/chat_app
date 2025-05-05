import 'package:chat_app/components/custom/app_color.dart';
import 'package:chat_app/components/custom/widget/custom_button.dart';
import 'package:chat_app/components/custom/widget/custom_text_form_field.dart';
import 'package:chat_app/components/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: AppColor.messageHintBackgroundColor,
                ),
              );
              context.read<LoginBloc>().add(ClearErrorMessageEvent());
            }
            if (state.isSuccess) {
              context.goNamed('main_page');
            }
          },
          child: Container(
            padding: const EdgeInsets.only(
              top: 250,
              left: 33,
              right: 33,
              bottom: 60,
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat, size: 150, color: AppColor.white),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Login',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: CustomTextFormField(
                    isPassword: true,
                    controller: _passwordController,
                    hintText: 'Password',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 10),
                  child: InkWell(
                    onTap: () => context.goNamed('register_page'),
                    child: Text(
                      'Or register account',
                      style: TextStyle(color: AppColor.textWhite),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                CustomButton(
                  text: 'Login',
                  onTap: () {
                    context.read<LoginBloc>().add(
                      LoginWithEmailEvent(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
