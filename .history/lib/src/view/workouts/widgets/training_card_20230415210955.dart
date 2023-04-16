import 'package:fittrack/src/core/base/models/training_model.dart';
import 'package:flutter/material.dart';

class TrainingCard extends StatelessWidget {
  const TrainingCard({super.key, required this.trainingModel});

  final TrainingModel trainingModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(
          '/update-workout/${state.trainingList[index].trainingName}',
        );
      },
      child: Container(
        height: 7.h,
        width: double.infinity,
        padding: EdgeInsets.all(13.sp),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: colors.mainColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "${state.trainingList[index].trainingName} - ${state.trainingList[index].time} min",
              textStyle: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset("delete".toSvg),
            ),
          ],
        ),
      ),
    );
  }
}
