import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:aufgabenplaner/pages/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../../../database/database.dart';
import '../../../main.dart';
import '../chatFunc.dart';

Widget newMessageTextField(context, chatId) {
  return Center(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spacer(flex: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width - (Platform.isIOS || Platform.isAndroid ? 150 : 200),
          child: TextField(
            controller: newMessage,
            cursorColor: Colors.white,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              border: Theme.of(context).inputDecorationTheme.border,
              focusedBorder: Theme.of(context).inputDecorationTheme.border,
              enabledBorder: Theme.of(context).inputDecorationTheme.border,
              contentPadding: EdgeInsets.all(8),
            ),
            //cursorColor: buttonColor,
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
            onTap: () async {
              if (newMessage.text != '') {
                messages[chats[chatId].item2].add(
                    Message(newMessage.text, DateTime.now(), 'delivered', 0, 0));
                await connection.transaction((connection) async {
                  await connection.query(
                      "INSERT INTO messages VALUES (@a, @b, @c, @d, @e, @f)",
                      substitutionValues: {
                        "a": '${chats[chatId].item1},${chats[chatId].item2}',
                        "b": newMessage.text,
                        "c": DateFormat('yyyy-MM-dd H:mm:s').format(DateTime.now()),
                        "d": 'delivered',
                        "e": 0,
                        "f": 0,
                      });
                });
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
