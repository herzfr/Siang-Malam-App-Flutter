import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/commons/functions/general_util.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:siangmalam/screens/home/pages/leave_permission/components/event_utils.dart';

class LeavePermissionBody extends StatefulWidget {
  const LeavePermissionBody({Key? key}) : super(key: key);

  @override
  State<LeavePermissionBody> createState() => _LeavePermissionBodyState();
}

class _LeavePermissionBodyState extends State<LeavePermissionBody> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }

    if (GeneralUtils().isDateBefore(todayDate, selectedDay)) {
      print("Date is afeter");
    } else {
      print("date is before");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, left: 5.w, right: 5.w),
      child: Column(
        children: [
          Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              side: BorderSide(color: mtGrey50, width: 2.0),
            ),
            child: TableCalendar(
              locale: 'id',
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              firstDay: firstDay,
              lastDay: lastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  if (day.weekday == DateTime.sunday) {
                    final text = DateFormat.E().format(day);
                    return Center(
                      child: Text(
                        text,
                        style: const TextStyle(color: mtRed600),
                      ),
                    );
                  }
                  return null;
                },
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              // Calendar Dates styling
              onDaySelected: _onDaySelected,
              // Calendar Days Styling
              onPageChanged: (focusedDay) {
                print("page changed $focusedDay");
                _focusedDay = focusedDay;
              },
              calendarStyle: calendarStyle,
              daysOfWeekStyle: daysOfTheWeekStyle,
              headerStyle: calendarHeaderStyle,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: primaryYellow,
                        border: Border.all(color: mtGrey50),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
