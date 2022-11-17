import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../main.dart';
import '../../infoRow/infoRow.dart';
import '../timelineDisplay.dart';

columnsTLD (indexTL) {
  return ListView.builder(
    itemCount: timeLineTasks.length,
    itemBuilder: (context, indexT) {
      var dateNow = DateTime(2022, 8, 5); //DateTime.now();
      var displayedTM = monthDisplay[indexTL].isBefore(DateTime(
          timeLineTasks[indexT].item1.end.year,
          timeLineTasks[indexT].item1.end.month + 1,
          1)) &&
          monthDisplay[indexTL]
              .isAfter(DateTime(dateNow.year, dateNow.month, 1));

      _getWidth() {
        if (monthDisplay[indexTL].month == dateNow.month &&
            monthDisplay[indexTL].year == dateNow.year) {
          var endToMonth =
              DateTime(dateNow.year, dateNow.month - 1, 0).day -
                  dateNow.day;
          return (199.6 /
              DateTime(dateNow.year, dateNow.month - 1, 0).day) *
              endToMonth;
        } else if (monthDisplay[indexTL].month ==
            timeLineTasks[indexT].item1.end.month &&
            monthDisplay[indexTL].year ==
                timeLineTasks[indexT].item1.end.year) {
          return (199.6 /
              DateTime(
                  timeLineTasks[indexT].item1.end.year,
                  timeLineTasks[indexT].item1.end.month + 1,
                  0)
                  .day) *
              timeLineTasks[indexT].item1.end.day;
        }
        return 199.6;
      }

      _getBorderShape() {
        if (monthDisplay[indexTL].month == dateNow.month &&
            monthDisplay[indexTL].year == dateNow.year) {
          return BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5));
        } else if (monthDisplay[indexTL].month ==
            timeLineTasks[indexT].item1.end.month &&
            monthDisplay[indexTL].year ==
                timeLineTasks[indexT].item1.end.year) {
          return BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5));
        }
      }

      return Container(
        height: 30,
        width: 200,
        decoration: BoxDecoration(
          color: indexT.isOdd ? Colors.grey[800] : Colors.transparent,
          border: Border(
            left: BorderSide(color: Colors.grey[100]!, width: 0.2),
            right: BorderSide(color: Colors.grey[100]!, width: 0.2),
            bottom: BorderSide(
                color: Colors.grey[100]!,
                width:
                indexT == timeLineTasks.length - 1 ? 0.4 : 0.0),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                monthDisplay[indexTL].month == dateNow.month
                    ? Spacer()
                    : Container(),
                Column(
                  children: [
                    Spacer(),
                    InkWell(
                      child: Container(
                        height: 18,
                        width: _getWidth(),
                        decoration: BoxDecoration(
                          color: displayedTM
                              ? timeLineTasks[indexT].item1.recColor
                              : Colors.transparent,
                          borderRadius: _getBorderShape(),
                        ),
                      ),
                      onHover: (isHover) {
                        if (isHover) {
                          hoverLeft[indexT] = true;
                          hoverRight[indexT] = true;
                        } else {
                          hoverLeft[indexT] = false;
                          hoverRight[indexT] = false;
                        }
                        setStateNeeded[6] = true;
                      },
                      onTap: () {
                        hoverLeft[indexT] = !hoverLeft[indexT];
                        hoverRight[indexT] = !hoverRight[indexT];
                        setStateNeeded[6] = true;
                      },
                    ),
                    Spacer(),
                  ],
                ),
                monthDisplay[indexTL].month ==
                    timeLineTasks[indexT].item1.end.month &&
                    monthDisplay[indexTL].year ==
                        timeLineTasks[indexT].item1.end.year
                    ? Spacer()
                    : Container(),
              ],
            ),
            Positioned(
              top: 6.5,
              right:
              _getWidth() < 160 ? _getWidth() : _getWidth() - 50,
              child: monthDisplay[indexTL].month == dateNow.month &&
                  monthDisplay[indexTL].year == dateNow.year
                  ? Visibility(
                visible: hoverLeft[indexT],
                child: Container(
                  padding: EdgeInsets.only(right: 3),
                  child: Text(
                    DateFormat('dd-MM').format(dateNow),
                    style: TextStyle(
                        color: _getWidth() < 160
                            ? Colors.white
                            : timeLineTasks[indexT]
                            .item1
                            .recColor
                            .computeLuminance() >
                            0.5
                            ? Colors.black
                            : Colors.transparent,
                        fontSize: 12),
                    overflow: TextOverflow.clip,
                  ),
                ),
              )
                  : Container(),
            ),
            Positioned(
              top: 6.5,
              left:
              _getWidth() < 160 ? _getWidth() : _getWidth() - 50,
              child: monthDisplay[indexTL].month ==
                  timeLineTasks[indexT].item1.end.month &&
                  monthDisplay[indexTL].year ==
                      timeLineTasks[indexT].item1.end.year
                  ? Visibility(
                visible: hoverRight[indexT],
                child: Container(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    DateFormat('dd-MM').format(
                        timeLineTasks[indexT].item1.end),
                    style: TextStyle(
                        color: _getWidth() < 160
                            ? Colors.white
                            : timeLineTasks[indexT]
                            .item1
                            .recColor
                            .computeLuminance() >
                            0.5
                            ? Colors.black
                            : Colors.white,
                        fontSize: 13),
                    overflow: TextOverflow.clip,
                  ),
                ),
              )
                  : Container(),
            ),
          ],
        ),
      );
    },
  );
}