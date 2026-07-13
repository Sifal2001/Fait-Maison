import 'package:login/utilities/getBreakfastMenuFromDB.dart';
import 'package:login/utilities/getDinnerMenuFromDB.dart';
import 'package:login/utilities/getLunchMenuFromDB.dart';

class DayMenu{
  final String day;
  final String breakfast;
  final String lunch;
  final String dinner;

  DayMenu({
   required this.day,
   required this.breakfast,
   required this.lunch,
   required this.dinner
  });

}

class WeeklyMenu{
  final List<DayMenu> days;

  WeeklyMenu({required this.days});
}

WeeklyMenu buildWeeklyMenu() {
  final dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday'];

  final counts = [breakfastMenu.length, lunchMenu.length, dinnerMenu.length];
  final shortest = counts.reduce((a, b) => a < b ? a : b);
  final count = shortest < 7 ? shortest : 7;

  List<DayMenu> days = [];
  for (int i = 0; i < count; i++) {
    days.add(DayMenu(
        day: dayNames[i],
        breakfast: breakfastMenu[i],
        lunch: lunchMenu[i],
        dinner: dinnerMenu[i],
    ));
  }
  return WeeklyMenu(days: days);
}