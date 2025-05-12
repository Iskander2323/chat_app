import 'package:chat_app/components/custom/app_color.dart';
import 'package:chat_app/components/custom/widget/custom_button.dart';
import 'package:chat_app/components/custom/widget/custom_text_form_field.dart';
import 'package:chat_app/components/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: AppColor.messageHintBackgroundColor,
                ),
              );
              context.read<RegisterBloc>().add(ClearErrorMessageEvent());
            }
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Account created successfully'),
                  backgroundColor: AppColor.messageHintBackgroundColor,
                ),
              );
              context.goNamed('main_page');
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
              top: 250,
              left: 33,
              right: 33,
              bottom: 60,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat, size: 150, color: AppColor.white),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: CustomTextFormField(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Login',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: CustomTextFormField(
                    controller: _passwordController,
                    isPassword: true,
                    hintText: 'Password',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: CustomTextFormField(
                    isPassword: true,
                    controller: _confirmPasswordController,
                    hintText: 'Confirm password',
                  ),
                ),
                Expanded(child: Container()),
                CustomButton(
                  text: 'Register',
                  onTap: () {
                    context.read<RegisterBloc>().add(
                      RegisterNewAccountEvent(
                        email: _emailController.text,
                        name: _nameController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
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
