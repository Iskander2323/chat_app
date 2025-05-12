import 'package:chat_app/components/data/model/user_model.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<UserModel> _localUsers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: BlocConsumer<MainBloc, MainState>(
          listenWhen:
              (previous, current) =>
                  previous.userList.length != current.userList.length,
          listener: (context, state) {
            if (!state.isSuccess) {
              context.goNamed('login_page');
            }
            final newUsers = state.userList;
            if (newUsers.length > _localUsers.length) {
              final addedMessage = newUsers.last;
              final newIndex = _localUsers.length;
              _localUsers.add(addedMessage);
              _listKey.currentState?.insertItem(newIndex);
            }
            if (newUsers.length < _localUsers.length) {
              for (int i = 0; i < _localUsers.length; i++) {
                final user = _localUsers[i];
                final stillExists = newUsers.any((u) => u.id == user.id);
                if (!stillExists) {
                  final removedUser = _localUsers.removeAt(i);

                  _listKey.currentState?.removeItem(
                    i,
                    (context, animation) => SizeTransition(
                      sizeFactor: animation,
                      child: ListTile(
                        title: Text('${removedUser.name}'),
                        leading: Icon(Icons.person_off),
                      ),
                    ),
                    duration: Duration(milliseconds: 300),
                  );
                  break; // тек біреуін жоямыз
                }
              }
            }
          },
          builder: (context, state) {
            if (state.userList.isNotEmpty) {
              _localUsers = List.from(state.userList);
            }
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
                                ? AnimatedList(
                                  key: _listKey,
                                  initialItemCount: _localUsers.length,
                                  itemBuilder: (context, index, animation) {
                                    final user = _localUsers[index];
                                    return SizeTransition(
                                      sizeFactor: animation,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: ListTile(
                                          minTileHeight: 65,
                                          title: Text('${user.name}'),
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
                                                  'user_id': user.id,
                                                  'user_email': user.email,
                                                  'user_name': user.name,
                                                },
                                              ),
                                          leading: Icon(Icons.person),
                                          trailing: Icon(Icons.chat),
                                        ),
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
