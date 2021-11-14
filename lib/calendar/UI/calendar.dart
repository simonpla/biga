import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../functions/calendarFunc.dart';

class Month extends StatefulWidget {
  const Month({Key? key}) : super(key: key);

  @override
  _MonthState createState() => _MonthState();
}

class _MonthState extends State<Month> {
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
  }

  Widget _monthNavigation() {
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
        top: BorderSide(color: uTextColor),
        left: BorderSide(color: uTextColor),
        bottom: BorderSide(color: uTextColor),
      );
    }
    else if (top == true && last == true) {
      return Border(
        top: BorderSide(color: uTextColor),
        left: BorderSide(color: uTextColor),
        right: BorderSide(color: uTextColor),
        bottom: BorderSide(color: uTextColor),
      );
    }
    else if (top == false && last == false) {
      return Border(
        left: BorderSide(color: uTextColor),
        bottom: BorderSide(color: uTextColor),
      );
    }
    else if (top == false && last == true) {
      return Border(
        left: BorderSide(color: uTextColor),
        right: BorderSide(color: uTextColor),
        bottom: BorderSide(color: uTextColor),
      );
    }
    return Border();
  }

  Widget _weekDays(bool top, String weekDay, bool weekView) {
    if (top == true) {
      return Expanded(
        flex: weekView == true ? 1 : 2,
        child: Container(
          child: Text(weekDay, style: TextStyle(color: uTextColor)),
        ),
      );
    }
    return Container();
  }

  double _getDayHeight(double height, bool weekView) {
    if(weekView == true) return 1.4;
    if (height < 500) return 5;
    return 9;
  }

  var widthDividend = 7;

  Widget _week(int weekNum, bool top, bool weekView) {
    return Container(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height, weekView),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Mo', weekView),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[weekNum * 7].toString(),
                        style: TextStyle(color: dayColor[weekNum * 7])),
                  ),
                ),
                Expanded(
                  flex: top == true ? weekView == true ? 15 : 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height, weekView),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Tue', weekView),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 1].toString(),
                        style: TextStyle(color: dayColor[(weekNum * 7) + 1])),
                  ),
                ),
                Expanded(
                  flex: top == true ? weekView == true ? 15 : 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height, weekView),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Wed', weekView),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 2].toString(),
                        style: TextStyle(color: dayColor[(weekNum * 7) + 2])),
                  ),
                ),
                Expanded(
                  flex: top == true ? weekView == true ? 15 : 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height, weekView),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Thu', weekView),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 3].toString(),
                        style: TextStyle(color: dayColor[(weekNum * 7) + 3])),
                  ),
                ),
                Expanded(
                  flex: top == true ? weekView == true ? 15 : 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height, weekView),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Fri', weekView),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 4].toString(),
                        style: TextStyle(color: dayColor[(weekNum * 7) + 4])),
                  ),
                ),
                Expanded(
                  flex: top == true ? weekView == true ? 15 : 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height, weekView),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, false),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Sat', weekView),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7) + 5].toString(),
                        style: TextStyle(color: dayColor[(weekNum * 7) + 5])),
                  ),
                ),
                Expanded(
                  flex: top == true ? weekView == true ? 15 : 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / widthDividend,
            height: MediaQuery.of(context).size.height /
                _getDayHeight(MediaQuery.of(context).size.height, weekView),
            decoration: BoxDecoration(
              color: backgroundDay,
              border: _getBorder(top, true),
            ),
            child: Column(
              children: [
                _weekDays(top, 'Sun', weekView),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(month[(weekNum * 7 + 6)].toString(),
                        style: TextStyle(color: dayColor[(weekNum * 7) + 6])),
                  ),
                ),
                Expanded(
                  flex: top == true ? weekView == true ? 15 : 6 : 8,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthDisplay() {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _monthNavigation(),
          //_weekDays(),
          _week(0, true, false),
          _week(1, false, false),
          _week(2, false, false),
          _week(3, false, false),
          _week(4, false, false),
          _week(5, false, false),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _monthDisplay();
  }
}

class Week extends StatefulWidget {
  const Week({Key? key}) : super(key: key);

  @override
  _WeekState createState() => _WeekState();
}

class _WeekState extends State<Week> {
  Widget _weekNavigation() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              setState(() {
                //TODO: change week
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
                //TODO: same as above
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

  Widget _weekDisplay() {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _weekNavigation(),
          //_weekDays(),
          _MonthState()._week(0, true, true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _weekDisplay();
  }
}
