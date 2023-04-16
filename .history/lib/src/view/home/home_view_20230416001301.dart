import 'package:firebase_auth/firebase_auth.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/bloc/training_bloc.dart';
import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/viewHeaderWidget/view_header_widget.dart';
import '../../core/constants/enums/route_enums.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseSingleton {
  late TrainingBloc _trainingBloc;

  @override
  void initState() {
    super.initState();
    _trainingBloc = context.read<TrainingBloc>();
    _trainingBloc.add(FetchAllDays());
  }

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
                    2.h.ph,
                    CustomText(
                      "Hello, ${FirebaseAuth.instance.currentUser!.displayName}",
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
                    2.h.ph,
                    BlocBuilder<TrainingBloc, TrainingState>(
                      bloc: _trainingBloc,
                      builder: (context, state) {
                        if (state is DaysLoading) {
                          return functions.platformIndicator();
                        } else if (state is DaysLoaded) {
                          return state.dayList.isNotNullOrEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.dayList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        context.go(
                                          "/workouts/${state.dayList[index].name}",
                                        );
                                      },
                                      child: Container(
                                        height: 7.h,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(13.sp),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 1.h),
                                        decoration: BoxDecoration(
                                          color:
                                              colors.mainColor.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: CustomText(
                                          state.dayList[index].name ?? "",
                                          textStyle: context
                                              .textTheme.headlineSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: CustomText(
                                    "You have not planned any training.",
                                    textStyle: context.textTheme.headlineSmall,
                                  ),
                                );
                        } else if (state is DaysError) {
                          return functions.errorText(state.errorMessage);
                        } else {
                          return functions.errorText("Something went wrong!");
                        }
                      },
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
