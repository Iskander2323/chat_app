import 'package:chat_app/components/spash/bloc/splash_bloc.dart';
import 'package:chat_app/components/spash/ui/splash_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(InitialEvent()),
      child: SplashPageBody(),
    );
  }
}
