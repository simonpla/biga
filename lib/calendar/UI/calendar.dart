import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../functions/calendarFunc.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
    setState(() {
      chosenMonthStr = formatterMonth.format(now);
      chosenMonth = int.tryParse(chosenMonthStr) ?? -1;
      year = formatterYear.format(now);
      yearNum = int.tryParse(year) ?? -1;
    });
    fillMonth();
    print(month);
  }

  Widget _navigation() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              setState(() {
                chosenMonthDate = DateTime(yearNum, chosenMonth - 1, 1);
                chosenMonthStr = formatterMonth.format(chosenMonthDate);
                chosenMonth = int.tryParse(chosenMonthStr) ?? -1;
                year = formatterYear.format(chosenMonthDate);
                yearNum = int.tryParse(year) ?? -1;
              });
              fillMonth();
            },
          ),
          Text(monthName(chosenMonth) + ' $yearNum',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {
              setState(() {
                chosenMonthDate = DateTime(yearNum, chosenMonth + 1, 1);
                chosenMonthStr = formatterMonth.format(chosenMonthDate);
                chosenMonth = int.tryParse(chosenMonthStr) ?? -1;
                year = formatterYear.format(chosenMonthDate);
                yearNum = int.tryParse(year) ?? -1;
              });
              fillMonth();
            },
          ),
        ],
      ),
    );
  }

  Border _getBorder(bool top, bool last) {
    if (top == true) {
      return Border(
        top: BorderSide(color: Colors.black87),
        left: BorderSide(color: Colors.black87),
        bottom: BorderSide(color: Colors.black87),
      );
    }
    if (top == true && last == true) {
      return Border(
        top: BorderSide(color: Colors.black87),
        left: BorderSide(color: Colors.black87),
        right: BorderSide(color: Colors.black87),
        bottom: BorderSide(color: Colors.black87),
      );
    }
    if (top == false && last == false) {
      return Border(
        left: BorderSide(color: Colors.black87),
        bottom: BorderSide(color: Colors.black87),
      );
    }
    if (top == false && last == true) {
      return Border(
        left: BorderSide(color: Colors.black87),
        right: BorderSide(color: Colors.black87),
        bottom: BorderSide(color: Colors.black87),
      );
    }
    return Border();
  }

  Widget _weekDays(bool top, String weekDay) {
    if (top == true) {
      return Expanded(
        flex: 2,
        child: Container(
          child: Text(weekDay),
        ),
      );
    }
    return Container();
  }

  double _getDayHeight(double height) {
    if (height < 500) return 5;
    return 9;
  }

  var widthDividend = 7;
  var backgroundDay = Colors.grey.shade100;

  Widget _week(int weekNum, bool top) {
    return Container(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Mo'),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[weekNum * 7].toString(), style: TextStyle(color: dayColor[weekNum * 7])),
                  ),
                ),
                Expanded(
                  flex: top == true ? 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Tue'),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 1].toString(), style: TextStyle(color: dayColor[(weekNum * 7) + 1])),
                  ),
                ),
                Expanded(
                  flex: top == true ? 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Wed'),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 2].toString(), style: TextStyle(color: dayColor[(weekNum * 7) + 2])),
                  ),
                ),
                Expanded(
                  flex: top == true ? 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Thu'),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 3].toString(), style: TextStyle(color: dayColor[(weekNum * 7) + 3])),
                  ),
                ),
                Expanded(
                  flex: top == true ? 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Fri'),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 4].toString(), style: TextStyle(color: dayColor[(weekNum * 7) + 4])),
                  ),
                ),
                Expanded(
                  flex: top == true ? 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Sat'),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 5].toString(), style: TextStyle(color: dayColor[(weekNum * 7) + 5])),
                  ),
                ),
                Expanded(
                  flex: top == true ? 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, true),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Sun'),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7 + 6)].toString(), style: TextStyle(color: dayColor[(weekNum * 7) + 6])),
                  ),
                ),
                Expanded(
                  flex: top == true ? 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendar() {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _navigation(),
          //_weekDays(),
          _week(0, true),
          _week(1, false),
          _week(2, false),
          _week(3, false),
          _week(4, false),
          _week(5, false),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _calendar();
  }
}
