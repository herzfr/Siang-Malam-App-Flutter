/* Created By Dwi Sutrisno */
import 'package:intl/intl.dart';

class GeneralUtils {
  /* Get Day Of The Weeks */
  dayOfweekToInd(String day) {
    switch (day) {
      case 'Monday':
        return 'Senin';
      case 'Tuesday':
        return 'Selasa';
      case 'Wednesday':
        return 'Rabu';
      case 'Thursday':
        return 'Kamis';
      case 'Friday':
        return 'Jumat';
      case 'Saturday':
        return 'Sabtu';
      case 'Sunday':
        return 'Minggu';
      default:
        return 'Minggu';
    }
  }

  /* Get Day Of The Weeks */
  dayOfweeks(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Sunday';
    }
  }

  /*Format Date*/
  formatDate(String format, String dateTimeString) {
    var parsedDate = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }

  /*Convert datetime to iso string*/
  convertoIsoString(DateTime time) {
    String isoDate = time.toIso8601String();
    return isoDate;
  }

  convertStringToDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return dateTime;
  }

  convertMinutesToHourString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} Jam, ${parts[1].padLeft(2, '0')} Menit';
  }

  getDurationInHours(DateTime startTime, DateTime endTime) {
    Duration diff = endTime.difference(startTime);
    var hours = diff.inHours;
    return hours;
  }

  getDurationInMinutes(DateTime startTime, DateTime endTime) {
    Duration diff = endTime.difference(startTime);
    var minutes = diff.inMinutes;
    return minutes;
  }

  getDurationInHoursFrmString(String start, String end) {
    DateTime startTime = DateTime.parse(start);
    DateTime endTime = DateTime.parse(end);
    Duration diff = endTime.difference(startTime);
    var hours = diff.inHours;
    return hours;
  }

  isDateBefore(DateTime start, DateTime end) {
    return start.isBefore(end);
  }

  isDateAfter(DateTime start, DateTime end) {
    return start.isAfter(end);
  }
}
