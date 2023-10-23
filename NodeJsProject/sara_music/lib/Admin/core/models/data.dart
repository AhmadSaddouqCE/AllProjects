import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/intl.dart';

class CalendarData {
  final String name;

  final DateTime date;
  final String position;
  final String rating;

  String getDate() {
    final formatter = DateFormat('kk:mm');

    return formatter.format(date);
  }

  CalendarData({
    required this.name,
    required this.date,
    required this.position,
    required this.rating,
  });
}
final List<CalendarData> calendarData = [
  CalendarData(
    name: 'Deniz Çolak',
    date: DateTime.now().add(Duration(days: -16, hours: 5)),
    position: "Violin Course",
    rating: '₽',
  ),
  CalendarData(
    name: 'John Doe',
    date: DateTime(2022,5,17,5),
    position: "Piano Course",
    rating: '₽',
  ),
  CalendarData(
    name: 'Joy Barker',
    date: DateTime.now().add(Duration(days: -10, hours: 3)),
    position: "Guitar Course",
    rating: '\$',
  ),
  CalendarData(
    name: 'Kate Hartley',
    date: DateTime.now().add(Duration(days: 6, hours: 6)),
    position: "Violin Course",
    rating: '\$',
  ),
  CalendarData(
    name: 'Fletcher Robson',
    date: DateTime.now().add(Duration(days: -18, hours: 9)),
    position: "Oud Course",
    rating: '\$',
  ),
  CalendarData(
    name: 'Aldrich Mason',
    date: DateTime.now().add(Duration(days: -12, hours: 2)),
    position: "Voice Course",
    rating: '\$',
  ),
  CalendarData(
    name: 'Phyllis Leonard',
    date: DateTime.now().add(Duration(days: -8, hours: 4)),
    position: "Oud Course",
    rating: '\$',
  ),
  CalendarData(
    name: 'Ken Rehbein',
    date: DateTime.now().add(Duration(days: -3, hours: 6)),
    position: "Oud Course",
    rating: '₽',
  ),
  CalendarData(
    name: 'Sydney Blake',
    date: DateTime.now().add(Duration(days: 4, hours: 6)),
    position: "Violin Course",
    rating: '₽',
  ),
  CalendarData(
    name: 'Megan Salazar',
    date: DateTime.now().add(Duration(days: 12, hours: 7)),
    position: "Piano Course",
    rating: '₽',
  ),
  CalendarData(
    name: 'Celeste Pena',
    date: DateTime.now().add(Duration(days: -14, hours: 5)),
    position: "Guitar Course",
    rating: '₽',
  ),
];