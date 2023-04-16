enum RouteEnums {
  login('/login'),
  register('/register'),
  home('/home'),
  workouts('/workouts/:day'),
  updateWorkout('/update-workout/:trainingName'),
  addWorkout('/add-workout/:day');

  final String routeName;
  const RouteEnums(this.routeName);
}
