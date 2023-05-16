import 'package:flutter_bloc/flutter_bloc.dart';

class ParameterCubit extends Cubit<bool> {
  ParameterCubit(super.value);

  set state(bool value) => emit(value);
}

class IncludeLowercaseCubit extends ParameterCubit {
  IncludeLowercaseCubit() : super(true);
}

class IncludeUppercaseCubit extends ParameterCubit {
  IncludeUppercaseCubit() : super(true);
}

class IncludeNumbersCubit extends ParameterCubit {
  IncludeNumbersCubit() : super(true);
}

class IncludeSymbolsCubit extends ParameterCubit {
  IncludeSymbolsCubit() : super(true);
}

class ExcludeSimilarCubit extends ParameterCubit {
  ExcludeSimilarCubit() : super(false);
}

class ExcludeAmbiguousCubit extends ParameterCubit {
  ExcludeAmbiguousCubit() : super(false);
}
