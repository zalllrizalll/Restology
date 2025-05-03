enum MyWorkManager {
  periodic('daily_reminder_task', 'Daily Reminder');

  final String uniqueName;
  final String taskName;

  const MyWorkManager(this.uniqueName, this.taskName);
}
