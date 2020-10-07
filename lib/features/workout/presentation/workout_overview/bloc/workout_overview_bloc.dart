import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/workout.dart';
import '../../../domain/usecases/watch_workouts.dart';

part 'workout_overview_bloc.freezed.dart';
part 'workout_overview_event.dart';
part 'workout_overview_state.dart';

class WorkoutOverviewBloc
    extends Bloc<WorkoutOverviewEvent, WorkoutOverviewState> {
  final WatchWorkouts _watchWorkouts;

  WorkoutOverviewBloc(this._watchWorkouts) : super(WorkoutOverviewState.initial());

  @override
  Stream<WorkoutOverviewState> mapEventToState(
    WorkoutOverviewEvent event,
  ) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield* _watchWorkouts.call().map(
              (failureOrWorkouts) => failureOrWorkouts.fold(
                (f) => const WorkoutOverviewState.error(),
                (workouts) => WorkoutOverviewState.success(workouts: workouts),
              ),
            );
      },
    );
  }
}
