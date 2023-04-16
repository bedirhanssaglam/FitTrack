enum RouteEnums {
  login('/login'),
  register('/register'),
  home('/home'),
  workouts('/workouts'),
  updateWorkout('/update-workout/:trainingName'),
  addWorkout('/add-workout');

  final String routeName;
  const RouteEnums(this.routeName);
}
