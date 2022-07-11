import 'package:flutter/material.dart';

import '../contacts.dart';
import '../contactsFunc.dart';

Widget contactsListDisplay(orgContext) {
  var halfCount = contacts.length / 2;
  var hasDecimal = halfCount % 1 != 0;
  if (hasDecimal) {
    halfCount = halfCount + 0.5;
  }

  return ListView.builder(
      itemCount: halfCount.toInt(),
      itemBuilder: (context, indexCLD) {
        return Row(
          children: [
            Expanded(child: contactsElement(0, indexCLD, orgContext)),
            !(hasDecimal && indexCLD * 2 == contacts.length - 1)
                ? Expanded(child: contactsElement(1, indexCLD, orgContext))
                : Container(
                    width: (MediaQuery.of(orgContext).size.width / 2) - 20),
          ],
        );
      });
}

Widget contactsElement(int lr, indexCLD, orgContext) {
  return Padding(
    padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
    child: Container(
      height: 60,
      width: (MediaQuery.of(orgContext).size.width / 2) - 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60), bottomLeft: Radius.circular(60)),
        border: Border.all(),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              border: Border.all(),
              //color: Colors.blue,
            ),
          ),
          Expanded(child: twoTextColumn(lr, indexCLD, false)),
          Expanded(child: twoTextColumn(lr, indexCLD, true)),
        ],
      ),
    ),
  );
}

Widget twoTextColumn(int lr, indexCLD, bool second) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Flexible(
        child: Container(
          height: 25,
          padding: EdgeInsets.only(left: 7, right: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(),
            color: Color(0xADABA2DF),
          ),
          child: Center(
            child: Text(
              second == true
                  ? contacts[indexCLD * 2 + lr].team
                  : contacts[indexCLD * 2 + lr].name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
      Text(
        second == true
            ? contacts[indexCLD * 2 + lr].mail
            : contacts[indexCLD * 2 + lr].tel,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ],
  );
}
