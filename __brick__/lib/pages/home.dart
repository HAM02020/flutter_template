import 'package:__brick__/generated/l10n.dart';
import 'package:__brick__/bloc/counter/counter_bloc.dart';
import 'package:__brick__/pages/demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (idx) => setState(() {
                _index = idx;
              }),
          items: [
            BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.brush),
                label: S.of(context).demo),
            BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.server),
                label: S.of(context).server),
            BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.landmark),
                label: S.of(context).blog),
          ]),
      drawer: Drawer(
        child: SafeArea(
          child: Column(children: [
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.affiliatetheme),
              title: Text(S.of(context).listTile),
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        title: Text(S.of(context).helloworld),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          BlocProvider(
            create: (context) => GetIt.instance.get<CounterBloc>(),
            child: const DemoPage(),
          ),
          const Center(child: Text("2")),
          const Center(child: Text("3"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GetIt.I.get<CounterBloc>().add(CounterAdd()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
