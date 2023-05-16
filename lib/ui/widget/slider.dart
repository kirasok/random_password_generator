import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:random_password_generator/logic/cubit/slider_cubit.dart';

class MySlider extends StatelessWidget {
  const MySlider({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SliderCubit, int>(
        builder: (context, state) => Container(
          margin: const EdgeInsets.only(
            left: 20,
            top: 40,
            right: 20,
            bottom: 0,
          ),
          child: FlutterSlider(
            values: [state.toDouble(), 256],
            min: 4,
            max: 256,
            step: FlutterSliderStep(
              step: 1,
              isPercentRange: true,
              rangeList: [
                FlutterSliderRangeStep(from: 1, to: 50, step: 1),
                FlutterSliderRangeStep(from: 50, to: 100, step: 8),
              ],
            ),
            tooltip: FlutterSliderTooltip(
              textStyle: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              alwaysShowTooltip: true,
              positionOffset: FlutterSliderTooltipPositionOffset(top: -30),
            ),
            handlerAnimation: FlutterSliderHandlerAnimation(
                curve: Curves.elasticOut,
                reverseCurve: Curves.bounceIn,
                duration: Duration(milliseconds: 500),
                scale: 1.5),
            onDragging: (handlerIndex, lowerValue, upperValue) =>
                BlocProvider.of<SliderCubit>(context).value =
                    (lowerValue as double).toInt(),
          ),
        ),
      );
}
