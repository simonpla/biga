import 'package:flutter/material.dart';
import '../contactsFunc.dart';

Widget contactsListDisplay(orgContext) {
  var _halfCount = contacts.length / 2;
  var _hasDecimal = _halfCount % 1 != 0;
  if (_hasDecimal) {
    _halfCount = _halfCount + 0.5;
  }
  if (MediaQuery.of(orgContext).size.width < 500) {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, indexCLD) {
          return Expanded(child: contactsElement(0, indexCLD, orgContext));
        });
  } else {
    return ListView.builder(
        itemCount: _halfCount.toInt(),
        itemBuilder: (context, indexCLD) {
          return Row(
            children: [
              Expanded(child: contactsElement(0, indexCLD * 2, orgContext)),
              !(_hasDecimal && indexCLD * 2 == contacts.length - 1)
                  ? Expanded(
                      child: contactsElement(1, indexCLD * 2, orgContext))
                  : Container(
                      width: (MediaQuery.of(orgContext).size.width / 2) - 20),
            ],
          );
        });
  }
}

Widget contactsElement(int lr, indexCLD, orgContext) {
  return Padding(
    padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
    child: Container(
      height: 60,
      width: MediaQuery.of(orgContext).size.width > 500
          ? MediaQuery.of(orgContext).size.width / 2 - 300
          : MediaQuery.of(orgContext).size.width - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60), bottomLeft: Radius.circular(60)),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: ClipOval(
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/5/56/Donald_Trump_official_portrait.jpg',
                fit: BoxFit.cover,
              ),
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
      Row(
        children: [
          Spacer(),
          Container(
            height: 25,
            padding: EdgeInsets.only(left: 7, right: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.white),
              color: Colors.deepPurpleAccent[200],//Color(0xADABA2DF),
            ),
            child: Center(
              child: Text(
                second
                    ? contacts[indexCLD + lr].team
                    : contacts[indexCLD + lr].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
      Text(
        second ? contacts[indexCLD + lr].mail : contacts[indexCLD + lr].tel,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ],
  );
}
