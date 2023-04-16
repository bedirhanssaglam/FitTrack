enum RouteEnums {
  splash('/splash'),
  login('/login'),
  register('/register'),
  home('/home'),
  workouts('/workouts/:day'),
  updateWorkout('/update-workout/:day'),
  addWorkout('/add-workout/:day');

  final String routeName;
  const RouteEnums(this.routeName);
}
