import 'package:chat_app/components/main/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          listener: (context, state) {
            if (!state.isSuccess) {
              context.goNamed('login_page');
            }
          },
          builder: (context, state) {
            return state.isLoading
                ? Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(
                    top: 60,
                    left: 33,
                    right: 33,
                    bottom: 60,
                  ),
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
                      Expanded(
                        child:
                            state.userList.isNotEmpty
                                ? ListView.builder(
                                  itemCount: state.userList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: ListTile(
                                        minTileHeight: 65,
                                        title: Text(
                                          '${state.userList[index].name}',
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        onTap:
                                            () => context.goNamed(
                                              'chat_page',
                                              extra: {
                                                'user_id':
                                                    state.userList[index].id,
                                                'user_email':
                                                    state.userList[index].email,
                                                'user_name':
                                                    state.userList[index].name,
                                              },
                                            ),
                                        leading: Icon(Icons.person),
                                        trailing: Icon(Icons.chat),
                                      ),
                                    );
                                  },
                                )
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: Text('No users found')),
                                    IconButton(
                                      icon: Icon(Icons.logout),
                                      onPressed: () {
                                        context.read<MainBloc>().add(
                                          LogoutEvent(),
                                        );
                                      },
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          context.read<MainBloc>().add(LogoutEvent());
                        },
                        color: Colors.red,
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
