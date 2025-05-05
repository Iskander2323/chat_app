import 'package:chat_app/components/firebase_api/firebase_api.dart';
import 'package:chat_app/components/login/bloc/login_bloc.dart';
import 'package:chat_app/components/login/ui/login_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(firebaseApi: context.read<FirebaseApi>()),
      child: LoginPageBody(),
    );
  }
}
