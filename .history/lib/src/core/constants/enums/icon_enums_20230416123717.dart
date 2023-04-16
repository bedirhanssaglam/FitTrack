enum IconEnums {
  login('/login'),
  register('/register'),
  home('/home'),
  workouts('/workouts/:day'),
  updateWorkout('/update-workout/:day'),
  addWorkout('/add-workout/:day');

  final String iconName;
  const IconEnums(this.iconName);
}
