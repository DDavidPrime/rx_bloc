import 'package:example/blocs/user_bloc.dart';
import 'package:example/models/user_model.dart';
import 'package:example/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:rx_bloc_list/rx_bloc_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxBlocList Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RxBlocProvider<UserBlocType>(
        create: (context) => UserBloc(repository: UserRepository()),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: RxPaginatedBuilder<UserBlocType, User>.withRefreshIndicator(
            builder: (context, snapshot, bloc) => _buildPaginatedList(snapshot),
            state: (bloc) => bloc.states.paginatedList,
            onBottomScrolled: (bloc) => bloc.events.loadPage(),
            onRefresh: (bloc) async {
              bloc.events.loadPage(reset: true);
              //return bloc.states.refreshDone;
            },
          ),
        ),
      );

  Widget _buildPaginatedList(AsyncSnapshot<PaginatedList<User>> snapshot) {
    if (!snapshot.hasData ||
        (snapshot.hasData && snapshot.data!.isInitialLoading)) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final list = snapshot.data!;

    return ListView.builder(
      itemBuilder: (context, index) => itemBuilder(list, index),
      itemCount: list.itemCount,
    );
  }

  Widget itemBuilder(PaginatedList<User> list, int index) {
    if (list.length == index) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 12),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Card(
      child: ListTile(
        title: Text(list[index].name),
      ),
    );
  }
}
