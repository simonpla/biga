import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:aufgabenplaner/main.dart';
import 'package:flutter/material.dart';

import '../chatFunc.dart';

Widget quickContacts(chatId) {
  return SizedBox(
    height: chats.length < 6
        ? 70.0 * chats.length
        : 342, // if is less than 6, make it smaller to show on bottom, else scrollable
    width: 70,
    child: ListView.builder(
      controller: ScrollController(),
      itemCount: chats.length,
      itemBuilder: (context, indexQC) {
        return SizedBox(
          height: 65,
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Positioned(
                  top: 45,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: primaryColorL,
                    ),
                    child: Text(chats[indexQC].item1,
                        overflow: TextOverflow.clip),
                  ),
                ),
              ],
            ),
            onTap: () {
              openedChat = indexQC;
              setStateNeeded[3] = true;
            },
          ),
        );
      },
    ),
  );
}
