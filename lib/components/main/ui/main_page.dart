import 'package:chat_app/components/firebase_api/firebase_api.dart';
import 'package:chat_app/components/main/bloc/main_bloc.dart';
import 'package:chat_app/components/main/ui/main_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              MainBloc(firebaseApi: context.read<FirebaseApi>())
                ..add(MainInitialEvent()),
      child: const MainPageBody(),
    );
  }
}
