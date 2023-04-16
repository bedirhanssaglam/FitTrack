enum RouteEnums {
  login('/login'),
  register('/register'),
  home('/home'),
  workouts('/workouts/:day'),
  updateWorkout('/update-workout/:trainingName/:day'),
  addWorkout('/add-workout/:day');

  final String routeName;
  const RouteEnums(this.routeName);
}
