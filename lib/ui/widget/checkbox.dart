import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_password_generator/logic/cubit/parameters.dart';

class MyCheckbox<T extends ParameterCubit> extends StatelessWidget {
  final String title;
  const MyCheckbox(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, bool>(
      builder: (context, state) => CheckboxListTile(
        title: Text(title),
        value: state,
        onChanged: (bool? a) {
          BlocProvider.of<T>(context).state = a ?? true;
        },
      ),
    );
  }
}
