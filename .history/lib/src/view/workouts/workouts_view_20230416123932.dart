import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:fittrack/src/view/workouts/widgets/training_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/bloc/training/training_bloc.dart';
import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/viewHeaderWidget/view_header_widget.dart';
import '../../core/constants/enums/route_enums.dart';

class WorkoutsView extends StatefulWidget {
  const WorkoutsView({super.key, required this.day});

  final String day;

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> with BaseSingleton {
  late TrainingBloc _trainingBloc;

  @override
  void initState() {
    super.initState();
    _trainingBloc = context.read<TrainingBloc>();
    _trainingBloc.add(FetchTrainingsByDay(widget.day));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("/add-workout/${widget.day}");
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
                      "Hello",
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
                    BlocConsumer<TrainingBloc, TrainingState>(
                      bloc: _trainingBloc,
                      listener: (context, state) {
                        if (state is TrainingAdded ||
                            state is TrainingDeleted ||
                            state is TrainingUpdated) {
                          return _trainingBloc
                              .add(FetchTrainingsByDay(widget.day));
                        }
                      },
                      buildWhen: (previous, currentState) {
                        return currentState is TrainingByDayLoading ||
                            currentState is TrainingByDayLoaded ||
                            currentState is TrainingByDayError;
                      },
                      builder: (context, state) {
                        if (state is TrainingByDayLoading) {
                          return functions.platformIndicator();
                        } else if (state is TrainingByDayLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.trainingList.length,
                            itemBuilder: (context, index) {
                              return TrainingCard(
                                trainingModel: state.trainingList[index],
                                day: widget.day,
                              );
                            },
                          );
                        } else if (state is TrainingByDayError) {
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
