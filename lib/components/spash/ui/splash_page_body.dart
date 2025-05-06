import 'package:chat_app/components/custom/app_color.dart';
import 'package:chat_app/components/spash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.goNamed('main_page');
          } else {
            context.goNamed('login_page');
          }
        },
        child: Center(child: Icon(Icons.chat, size: 200)),
      ),
    );
  }
}
