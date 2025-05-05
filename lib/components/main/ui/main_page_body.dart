import 'package:chat_app/components/main/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({super.key});

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: BlocConsumer<MainBloc, MainState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state.isLoading
                ? Container(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(),
                )
                : Container(
                  padding: EdgeInsets.only(
                    top: 60,
                    left: 33,
                    right: 33,
                    bottom: 60,
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return index == 1
                              ? Icon(Icons.chat)
                              : ListTile(
                                title: Text('Item $index'),
                                subtitle: Text('Subtitle $index'),
                                leading: Icon(Icons.chat),
                                trailing: Icon(Icons.arrow_forward),
                              );
                        },
                      ),
                    ],
                  ),
                );
          },
        ),
      ),
    );
  }
}
