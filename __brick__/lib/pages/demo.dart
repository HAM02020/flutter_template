import 'package:__brick__/bloc/counter/counter_bloc.dart';
import 'package:__brick__/bloc/user_settings/user_setting_bloc.dart';
import 'package:__brick__/generated/l10n.dart';
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
        var userSettingCubit = context.watch<UserSettingCubit>();

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
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.language),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(S.of(context).changeLocale)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(S.of(context).Chinese),
                      Radio(
                        value: UserLocaleMode.zh,
                        groupValue: userSettingCubit.state.localMode,
                        onChanged: (value) =>
                            userSettingCubit.setLocaleMode(value!),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(S.of(context).English),
                      Radio(
                        value: UserLocaleMode.en,
                        groupValue: userSettingCubit.state.localMode,
                        onChanged: (value) =>
                            userSettingCubit.setLocaleMode(value!),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(S.of(context).system),
                      Radio(
                        value: UserLocaleMode.system,
                        groupValue: userSettingCubit.state.localMode,
                        onChanged: (value) =>
                            userSettingCubit.setLocaleMode(value!),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.moon),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(S.of(context).changeThemeMode),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(S.of(context).lightMode),
                      Radio(
                        value: UserTheme.light,
                        groupValue: userSettingCubit.state.userTheme,
                        onChanged: (value) => userSettingCubit.setTheme(value!),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(S.of(context).darkMode),
                      Radio(
                        value: UserTheme.dark,
                        groupValue: userSettingCubit.state.userTheme,
                        onChanged: (value) {
                          userSettingCubit.setTheme(value!);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(S.of(context).system),
                      Radio(
                        value: UserTheme.system,
                        groupValue: userSettingCubit.state.userTheme,
                        onChanged: (value) => userSettingCubit.setTheme(value!),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
