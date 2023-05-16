import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_strength/password_strength.dart';
import 'package:random_password_generator/data/password_generator.dart';

abstract class PasswordState {}

class PasswordGenerated extends PasswordState {
  final String password;
  late final double strength;
  String get message {
    if (strength < 0.2)
      return "Password is extremely weak";
    else if (strength < 0.4)
      return "Password is weak";
    else if (strength < 0.6)
      return "Password is normal";
    else if (strength < 0.8)
      return "Password is strong";
    else if (strength < 1.0)
      return "Password is especially strong";
    else if (strength == 1.0)
      return "Password is impossible to hack";
    else
      return "Some error occurred when we estimated password strength. Please, leave issue on our GitHub";
  }

  PasswordGenerated(this.password) {
    strength = estimatePasswordStrength(password);
    Clipboard.setData(ClipboardData(text: password));
  }
}

class PasswordEmpty extends PasswordState {}

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordEmpty());

  void generate(
          int length,
          bool includeLowercase,
          bool includeUppercase,
          bool includeNumbers,
          bool includeSymbols,
          bool excludeSimilar,
          bool excludeAmbiguous) =>
      emit(
        PasswordGenerated(
          generatePassword(
            length,
            includeLowercase,
            includeUppercase,
            includeNumbers,
            includeSymbols,
            excludeSimilar,
            excludeAmbiguous,
          ),
        ),
      );
}
