import 'package:aufgabenplaner/pages/chat/chatFunc.dart';
import 'package:flutter/material.dart';

Widget topInfoBar(chatId) {
  return Container(
    height: 30,
    width: 200,
    decoration: BoxDecoration(
      color: Color(0xFF050717),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
    ),
    child: Row(
      children: [
        SizedBox(width: 5),
        InkWell(
          child: Icon(Icons.phone, color: Colors.white),
          onTap: () {},
        ),
        SizedBox(width: 5),
        Expanded(
          child: Center(
            child: Text('${chatId != -1 ? getChat(chatId, 0).item1 : 'fp'}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
        SizedBox(width: 5),
        InkWell(
          child: Icon(Icons.video_call, color: Colors.white),
          onTap: () {},
        ),
        SizedBox(width: 5),
      ],
    ),
  );
}
