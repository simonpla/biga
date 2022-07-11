import 'package:aufgabenplaner/main.dart';
import 'package:flutter/material.dart';

class Pair<T1, T2> {
  T1 item1;
  T2 item2;

  Pair(this.item1, this.item2);
}

class Message {
  var text;
  DateTime sentTime;
  var sentStatus; // failed, waiting, delivered, seen
  var chatId; // id of chat
  var sender; // id of sender, self is 0

  Message(this.text, this.sentTime, this.sentStatus, this.chatId, this.sender);
}

List<Pair<String, int>> chats = List.of([Pair('tomtom', 0)],
    growable: true); // name, pointer to messages index

List<List<Message>> messages = List.of([
  [Message('hi', DateTime.now(), 'delivered', 0, 0)]
], growable: true);

ScrollController mDSC = ScrollController();

var idCounter = 0;

var openedChat = 0;

addChat(chatId, name) {
  if (chatId + 1 > chats.length) {
    chats.addAll(List.generate(chatId - chats.length + 1, (index) => Pair('', -1)));
  }
  chats[chatId].item1 = name;

  // add pointer to messages index
  chats[chatId].item2 = messages.length;
  // add list to messages
  messages.add(List.empty(growable: true));

  setStateNeeded[3] = true;
}

getChat(chatId, itemId) {
  /*
  itemId:
  0 - name
  1 - messages
   */
  switch (itemId) {
    case 0:
      return chats[chatId];
    case 1:
      return messages[chats[chatId].item2];
  }
}
