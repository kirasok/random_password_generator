import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<int> {
  SliderCubit() : super(16);

  set value(int value) => emit(value);
}
