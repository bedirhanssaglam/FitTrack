import 'package:fittrack/src/core/base/models/training_model.dart';
import 'package:fittrack/src/core/base/singleton/base_singleton.dart';
import 'package:fittrack/src/core/constants/enums/icon_enums.dart';
import 'package:fittrack/src/core/extensions/context_extensions.dart';
import 'package:fittrack/src/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../core/base/bloc/training/training_bloc.dart';
import '../../../core/components/text/custom_text.dart';

class TrainingCard extends StatelessWidget with BaseSingleton {
  TrainingCard({super.key, required this.trainingModel, required this.day});

  final TrainingModel trainingModel;
  final String day;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(
          '/update-workout/$day',
          extra: {
            'trainingModel': trainingModel,
          },
        );
      },
      child: Container(
        height: 7.h,
        width: double.infinity,
        padding: EdgeInsets.all(12.sp),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: colors.mainColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "${trainingModel.trainingName} - ${trainingModel.time} min",
              textStyle: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            InkWell(
              onTap: () {
                context.read<TrainingBloc>().add(
                      DeleteTraining(trainingModel.id, day, context),
                    );
              },
              child: SvgPicture.asset(IconEnums.delete.iconName.toSvg),
            ),
          ],
        ),
      ),
    );
  }
}
