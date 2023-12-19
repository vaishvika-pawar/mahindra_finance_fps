import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahindra_finance_fps/custom_cards.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  bool weekSelection = true;
  DateTime selectedDate = DateTime.now();
  DateTime? startDate = DateTime(2023, 12, 18);
  DateTime? endDate = DateTime(2023, 12, 23);
  List<DateTime> dates = [];

  DateTimeRange? dateRange =
      DateTimeRange(start: DateTime(2023, 12, 18), end: DateTime(2023, 12, 23));

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    generateDatesInRange();
  }

  generateDatesInRange() {
    dates.clear();
    if (startDate == null || endDate == null) {
      return [selectedDate];
    }
    for (var day = dateRange!.start;
        day.isBefore(dateRange!.end.add(Duration(days: 1)));
        day = day.add(Duration(days: 1))) {
      dates.add(day);
    }
    setState(() {});
  }

  Widget dayCalendarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        TableCalendar(
          focusedDay: selectedDate,
          firstDay: DateTime(2023, 1, 1),
          lastDay: DateTime(2025, 1, 1),
        ),
        showTabView(),
      ]),
    );
  }

  Widget weekCalendarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        TableCalendar(
          focusedDay: dateRange!.start,
          firstDay: DateTime(2023, 1, 1),
          lastDay: DateTime(2025, 1, 1),
          rangeStartDay: dateRange!.start,
          rangeEndDay: dateRange!.end,
        ),
        showTabView(),
      ]),
    );
  }

  Widget showTabView() {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: [
            Tab(child: Text('All')),
            Tab(child: Text('HRD')),
            Tab(child: Text('Tech 1')),
            Tab(child: Text('Follow up'))
          ],
        ),
        TabBarView(children: [
          showListView('All'),
          showListView('HRD'),
          showListView('Tech 1'),
          showListView('Follow up'),
        ]),
      ],
    );
  }

  Widget showListView(String type) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          return weekSelection
              ? DayCard(
                  date: dates.elementAt(index), hrd: 3, tech: 2, followup: 5)
              : DetailsCard();
        });
  }

  @override
  Widget build(BuildContext context) {
    var blue = Colors.blue;
    var white = Colors.white;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const Text(
          'My Calendar',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: !weekSelection ? blue : white,
              onPrimary: weekSelection ? blue : white,
            ),
            onPressed: () {
              setState(() {
                weekSelection = false;
                startDate = null;
                endDate = null;
                dates.clear();
                dateRange = null;
              });
            },
            child: const Text('Day'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: weekSelection ? blue : white,
              onPrimary: !weekSelection ? blue : white,
            ),
            onPressed: () {
              setState(() {
                weekSelection = true;
                startDate = DateTime(2023, 12, 18);
                endDate = DateTime(2023, 12, 23);
                generateDatesInRange();
                dateRange = DateTimeRange(
                    start: DateTime(2023, 12, 18), end: DateTime(2023, 12, 23));
              });
            },
            child: const Text('Week'),
          ),
        ],
      ),
      body: weekSelection ? weekCalendarView() : dayCalendarView(),
    );
  }
}
