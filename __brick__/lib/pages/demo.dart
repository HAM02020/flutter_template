import 'package:{{name.snakeCase()}}/bloc/bloc/counter_bloc.dart';
import 'package:{{name.snakeCase()}}/cubit/user_setting_bloc.dart';
import 'package:{{name.snakeCase()}}/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                      '${BlocProvider.of<CounterBloc>(context).state.count}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: "a",
                    onPressed: () =>
                        GetIt.I.get<CounterBloc>().add(CounterMinus()),
                    tooltip: 'Decrement',
                    child: const FaIcon(FontAwesomeIcons.minus),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  FloatingActionButton(
                    heroTag: "b",
                    onPressed: () =>
                        //BlocProvider.of<CounterBloc>(context).add(CounterAdd()),
                        GetIt.instance.get<CounterBloc>().add(CounterAdd()),
                    tooltip: 'Increment',
                    child: const FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.language),
                  Switch(
                      value: GetIt.I.get<UserSettingCubit>().isEnglish,
                      onChanged: (value) =>
                          GetIt.I.get<UserSettingCubit>().switchLocale()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.moon),
                  Switch(
                    onChanged: (bool value) =>
                        BlocProvider.of<UserSettingCubit>(context)
                            .switchTheme(),
                    value:
                        BlocProvider.of<UserSettingCubit>(context).isDarkMode,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
