import 'package:fit_track/src/core/base/singleton/base_singleton.dart';
import 'package:fit_track/src/core/components/button/custom_button.dart';
import 'package:fit_track/src/core/components/text/custom_text.dart';
import 'package:fit_track/src/core/components/textFormField/text_form_field.dart';
import 'package:fit_track/src/core/components/viewHeaderWidget/view_header_widget.dart';
import 'package:fit_track/src/core/constants/enums/route_enums.dart';
import 'package:fit_track/src/core/extensions/num_extensions.dart';
import 'package:fit_track/src/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseSingleton {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewHeaderWidget(
                title: "Days",
                onTap: () {},
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
                      "Choose the day you want to make reservations",
                      textStyle: context.textTheme.titleMedium?.copyWith(
                        color: colors.silver,
                      ),
                    ),
                    3.h.ph,
                    InkWell(
                      onTap: () {
                        context.go(RouteEnums.workouts.routeName);
                      },
                      child: Container(
                        height: 7.h,
                        width: double.infinity,
                        padding: EdgeInsets.all(13.sp),
                        decoration: BoxDecoration(
                          color: colors.mainColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CustomText(
                          "Monday",
                          textStyle: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
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
