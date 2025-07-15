class TimeUtils {
  // TODO: Реализовать расчет времени до прибытия
  static String calculateTimeLeft(DateTime now, String trainTime) {
    return '02:15'; // Заглушка
  }

  static bool isWeekend(DateTime date) {
    final weekday = date.weekday;
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }
}