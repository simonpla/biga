import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:aufgabenplaner/pages/chat/chat.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../chatFunc.dart';

Widget newMessageTextField(context, chatId) {
  return Center(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spacer(flex: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width - 200,
          child: TextField(
            controller: newMessage,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.6, color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.7, color: buttonColor!),
              ),
            ),
            cursorColor: buttonColor,
          ),
        ),
        Spacer(),
        SizedBox(
          height: 50,
          width: 40,
          child: InkWell(
            child: Icon(Icons.send_rounded),
            radius: 17,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (newMessage.text != '') {
                messages[chats[chatId].item2].add(
                    Message(newMessage.text, DateTime.now(), 'delivered', 0, 0));
              }
              newMessage.text = ''; // reset text
              setStateNeeded[3] = true;
              afterUpdatedMD = 0;
              mDSC = ScrollController();
            },
          ),
        ),
        Spacer(),
      ],
    ),
  );
}
