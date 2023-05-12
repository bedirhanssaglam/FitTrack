import 'package:firebase_auth/firebase_auth.dart';
import 'package:fittrack/src/core/constants/app/app_constants.dart';
import 'package:fittrack/src/core/constants/enums/local_storage_enums.dart';
import 'package:fittrack/src/core/extensions/context_extensions.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:fittrack/src/core/init/cache/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/bloc/training/training_bloc.dart';
import '../../core/base/models/days_model.dart';
import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/popup/log_out_popup.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/viewHeaderWidget/view_header_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseSingleton {
  late TrainingBloc _trainingBloc;
  String? name;

  setName() async {
    if (FirebaseAuth.instance.currentUser?.displayName == null) {
      name = await CacheManager.getString(LocalStorageEnums.userName.name);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    setName();
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
                title: AppConstants.instance.daysTitle,
                onTap: () => PopupUtils.logOutPopup(context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    2.h.ph,
                    Row(
                      children: [
                        Text(
                          AppConstants.instance.hello,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.instance.fontFamily,
                            fontSize: 20.sp,
                          ),
                        ),
                        FirebaseAuth.instance.currentUser?.displayName != null
                            ? Text(
                                ", ${FirebaseAuth.instance.currentUser?.displayName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppConstants.instance.fontFamily,
                                  fontSize: 20.sp,
                                ),
                              )
                            : name != null
                                ? Text(
                                    ", $name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          AppConstants.instance.fontFamily,
                                      fontSize: 20.sp,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                      ],
                    ),
                    1.h.ph,
                    CustomText(
                      AppConstants.instance.chooseDayTitle,
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
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.dayList.length,
                            itemBuilder: (context, index) {
                              return _HomeDayCard(day: state.dayList[index]);
                            },
                          );
                        } else if (state is DaysError) {
                          return functions.errorText(state.errorMessage);
                        } else {
                          return functions
                              .errorText(AppConstants.instance.error);
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

class _HomeDayCard extends StatelessWidget with BaseSingleton {
  const _HomeDayCard({
    required this.day,
  });

  final DaysModel day;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(
          "/workouts/${day.name}",
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
        child: CustomText(
          day.name ?? "",
          textStyle: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
