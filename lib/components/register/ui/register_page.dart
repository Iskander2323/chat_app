import 'package:chat_app/components/firebase_api/firebase_api.dart';
import 'package:chat_app/components/register/bloc/register_bloc.dart';
import 'package:chat_app/components/register/ui/register_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => RegisterBloc(firebaseApi: context.read<FirebaseApi>()),
      child: RegisterPageBody(),
    );
  }
}
