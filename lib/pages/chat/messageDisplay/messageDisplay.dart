import 'package:flutter/material.dart';
import '../chat.dart';
import '../chatFunc.dart';

Widget messageDisplay(orgContext, chatId) {
  if (afterUpdatedMD == 0) {
    Future.delayed(Duration(milliseconds: 10), () {
      mDSC.animateTo(
          mDSC.position.maxScrollExtent,
          duration: Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }
  afterUpdatedMD = -1;
  return Padding(
    padding: EdgeInsets.only(left: 66.7, right: 16.7),
    child: ListView.builder(
      controller: mDSC,
      itemCount: messages[chats[chatId].item2].length,
      itemBuilder: (context, indexMG) {
        return Align(
          alignment: getChat(chatId, 1)[indexMG].sender ==
                  0 // messages[indexMG].sender == 0
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 30, bottom: 10),
              //height: 40,
              //width: 100,
              decoration: BoxDecoration(
                  color: getChat(chatId, 1)[indexMG].sender ==
                          0 //messages[indexMG].sender == 0
                      ? Colors.blue.shade500
                      : Colors.grey.shade300,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: SelectableText(
                '${getChat(chatId, 1)[indexMG].text ?? "Error: could not get message"}', //messages[indexMG].text,
                style: TextStyle(
                  color: getChat(chatId, 1)[indexMG].sender ==
                          0 //messages[indexMG].sender == 0
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
