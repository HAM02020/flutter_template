import 'package:{{{name.snakeCase()}}}/cubit/user_setting_bloc.dart';
import 'package:{{{name.snakeCase()}}}/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    Dio().get("https://www.baidu.com").then((value) => debugPrint(value.data));
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            FloatingActionButton.extended(
              heroTag: "toSecondPage",
              onPressed: () => context.go('/second'),
              label: Text(S.of(context).toSecondPage),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).countTimes,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FloatingActionButton(
                  heroTag: "a",
                  onPressed: null,
                  tooltip: 'Decrement',
                  child: FaIcon(FontAwesomeIcons.minus),
                ),
                const SizedBox(
                  width: 50,
                ),
                FloatingActionButton(
                  heroTag: "b",
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: const FaIcon(FontAwesomeIcons.solidSun),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.language),
                Switch(
                    value: BlocProvider.of<UserSettingCubit>(context).isEnglish,
                    onChanged: (value) =>
                        BlocProvider.of<UserSettingCubit>(context)
                            .switchLocale()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.moon),
                Switch(
                  onChanged: (bool value) =>
                      BlocProvider.of<UserSettingCubit>(context).switchTheme(),
                  value: BlocProvider.of<UserSettingCubit>(context).isDarkMode,
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
