import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_password_generator/logic/cubit/parameters.dart';
import 'package:random_password_generator/logic/cubit/password_cubit.dart';
import 'package:random_password_generator/logic/cubit/slider_cubit.dart';
import 'package:random_password_generator/ui/widget/checkbox.dart';
import 'package:random_password_generator/ui/widget/slider.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  Color colorOfPasswordBackground = Colors.transparent;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SliderCubit()),
          BlocProvider(create: (_) => IncludeLowercaseCubit()),
          BlocProvider(create: (_) => IncludeUppercaseCubit()),
          BlocProvider(create: (_) => IncludeNumbersCubit()),
          BlocProvider(create: (_) => IncludeSymbolsCubit()),
          BlocProvider(create: (_) => ExcludeSimilarCubit()),
          BlocProvider(create: (_) => ExcludeAmbiguousCubit()),
          BlocProvider(create: (_) => PasswordCubit()),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text("Random Password Generator"),
          ),
          body: Builder(builder: (context) {
            final passwordCubit = context.watch<PasswordCubit>();
            final passwordState = passwordCubit.state;
            final sliderState = context.watch<SliderCubit>().state;
            final includeLowercase =
                context.watch<IncludeLowercaseCubit>().state;
            final includeUppercase =
                context.watch<IncludeUppercaseCubit>().state;
            final includeNumbers = context.watch<IncludeNumbersCubit>().state;
            final includeSymbols = context.watch<IncludeSymbolsCubit>().state;
            final excludeSimilar = context.watch<ExcludeSimilarCubit>().state;
            final excludeAmbiguous =
                context.watch<ExcludeAmbiguousCubit>().state;
            return ListView(
              children: [
                MySlider(),
                MyCheckbox<IncludeLowercaseCubit>("Include Lowercase"),
                MyCheckbox<IncludeUppercaseCubit>("Include Uppercase"),
                MyCheckbox<IncludeNumbersCubit>("Include Numbers"),
                MyCheckbox<IncludeSymbolsCubit>("Include Symbols"),
                MyCheckbox<ExcludeSimilarCubit>("Exclude Similar"),
                MyCheckbox<ExcludeAmbiguousCubit>("Exclude Ambiguous"),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      passwordCubit.generate(
                          sliderState,
                          includeLowercase,
                          includeUppercase,
                          includeNumbers,
                          includeSymbols,
                          excludeSimilar,
                          excludeAmbiguous);
                      if (passwordState is PasswordGenerated)
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(passwordState.message),
                            ),
                          );
                        });
                    },
                    child: Text("Generate Password"),
                  ),
                ),
                passwordState is PasswordGenerated
                    ? Card(
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(passwordState.password,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontFamily: 'RobotoMono',
                                  )),
                        ),
                      )
                    : Container(),
              ],
            );
          }),
        ),
      );
}
