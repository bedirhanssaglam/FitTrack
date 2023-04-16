enum IconEnums {
  facebook('facebook'),
  google('google'),
  apple('apple'),
  addWorkout('/add-workout/:day');

  final String iconName;
  const IconEnums(this.iconName);
}
