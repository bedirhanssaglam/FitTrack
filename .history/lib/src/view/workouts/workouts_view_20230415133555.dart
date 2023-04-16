import 'package:fit_track/src/core/base/singleton/base_singleton.dart';
import 'package:fit_track/src/core/extensions/num_extensions.dart';
import 'package:fit_track/src/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../core/components/text/custom_text.dart';
import '../../core/components/viewHeaderWidget/view_header_widget.dart';
import '../../core/constants/enums/route_enums.dart';

class WorkoutsView extends StatefulWidget {
  const WorkoutsView({super.key});

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> with BaseSingleton {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(RouteEnums.addWorkout.routeName);
        },
        backgroundColor: colors.mainColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewHeaderWidget(
                title: "Workouts",
                onTap: () {
                  context.go(RouteEnums.home.routeName);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    3.h.ph,
                    CustomText(
                      "Hello, İrem",
                      textStyle: context.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    1.h.ph,
                    CustomText(
                      "Select the workout you want to change",
                      textStyle: context.textTheme.titleMedium?.copyWith(
                        color: colors.silver,
                      ),
                    ),
                    3.h.ph,
                    InkWell(
                      onTap: () {
                        context.go('/update-workout/Yoga');
                      },
                      child: Container(
                        height: 7.h,
                        width: double.infinity,
                        padding: EdgeInsets.all(13.sp),
                        decoration: BoxDecoration(
                          color: colors.mainColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              "Yoga - 30 min",
                              textStyle:
                                  context.textTheme.headlineSmall?.copyWith(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
