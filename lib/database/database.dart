import 'dart:convert';

import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/chat/chatFunc.dart';
import 'package:aufgabenplaner/pages/notes/notesList/notesList.dart';
import 'package:aufgabenplaner/pages/tasks/timeline/infoRow/infoRow.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:postgres/postgres.dart';
import '../pages/contacts/contactsFunc.dart';
import '../pages/notes/notes.dart';
import '../pages/tasks/kanban/kanban.dart';
import '../pages/tasks/tasks_page.dart';
import '../pages/tasks/timeline/timelineDisplay/timelineDisplay.dart';

var connection = PostgreSQLConnection(
  "localhost",
  26257,
  "defaultdb",
  username: "test_user",
  password: "test123",
  useSSL: true,
  allowClearTextPassword: true,
);

_getContactByName(var names) {
  List<Contact> _contacts = [];
  var contactInfo;

  for (int i = 0; i < names.length - 1; i++) {
    contactInfo = names[i].split(',');
    _contacts.add(Contact(contactInfo[0], contactInfo[1], contactInfo[2],
        contactInfo[3], contactInfo[4]));
  }
  return _contacts;
}

_readTasks() async {
  //try {
    await connection.transaction((ctx) async {
      var dbTaskCards = await ctx.query("SELECT * FROM taskCards");
      for (int i = 0; i < dbTaskCards.length; i++) {
        tasks.add(List<Task>.empty(growable: true));
        taskCards.add(PairK(dbTaskCards[i][0], FocusNode()));
        usableTimeLineTasks.add(List.empty(growable: true));
        editName.add(false);
        taskCardExpanded.add(PairK(false, -1));
      }

      var db_tasks = await ctx.query("SELECT * FROM tasks");
      for (int i = 0; i < db_tasks.length; i++) {
        // if task already exists at index
        try {
          if (tasks[int.parse(db_tasks[i][0][0])][int.parse(db_tasks[i][0][1])]
                  .title !=
              '') {
            continue;
          }
        } catch (g) {}

        tasks[int.parse(db_tasks[i][0][0])].add(Task(
            db_tasks[i][1],
            db_tasks[i][4],
            db_tasks[i][2],
            db_tasks[i][3],
            _getContactByName(db_tasks[i][5].split(';')),
            Pair(db_tasks[i][6], Colors.purple[200]),
            Color(int.parse(db_tasks[i][7]))));
        usableTimeLineTasks[int.parse(db_tasks[i][0][0])]
            .add(tasks[int.parse(db_tasks[i][0][0])].last);
      }

      var db_tl = await ctx.query("SELECT * FROM timelineTasks");
      for (int i = 0; i < db_tl.length; i++) {
        var id = db_tl[i][0].split(',');
        id = [int.parse(id[0]), int.parse(id[1])];
        timeLineTasks.add(PairTL(tasks[id[0]].last, id));
        usableTimeLineTasks[id[0]].removeAt(id[1]);
        hoverLeft.add(false);
        hoverRight.add(false);
      }
    });
  //} catch (f) {
  //  print(f);
  //}
  setStateNeeded[4] = true;
}

_readContacts() async {
  try {
    await connection.transaction((ctx) async {
      var dbContacts = await ctx.query("SELECT * FROM contacts");
      for (var dbContact in dbContacts) {
        contacts.add(Contact(dbContact[0], dbContact[1], dbContact[2],
            dbContact[3], dbContact[4]));
      }
    });
  } catch (h) {
    print(h);
  }
  setStateNeeded[2] = true;
}

_readMessages() async {
  try {
    await connection.transaction((ctx) async {
      var dbMessages = await ctx.query("SELECT * FROM messages");
      for (var dbMessage in dbMessages) {
        var currChat = dbMessage[0].split(',');

        var containsId = false;
        for (int i = 0; i < chats.length; i++) {
          if (chats[i].item2 == int.parse(currChat[1])) {
            containsId = true;
            break;
          }
        }
        if (!containsId) {
          chats.add(Pair(currChat[0], int.parse(currChat[1])));
          messages.add(List.empty(growable: true));
        }

        messages[int.parse(currChat[1])].add(Message(dbMessage[1], dbMessage[2],
            dbMessage[3], dbMessage[4], dbMessage[5]));
      }
    });
  } catch (i) {
    print(i);
  }
  setStateNeeded[3] = true;
}

_readNotes() async {
  //try {
  await connection.transaction((ctx) async {
    var dbNotes = await ctx.query("SELECT * FROM notes");

    for (int i = 0; i < dbNotes.length; i++) {
      while (notes.length < dbNotes[i][0] + 1) {
        notes.add(PairNL('shouldn\'t be here', Colors.grey[400]));
        textFields.add(List.empty(growable: true));
        hasChangedText.add(List.empty(growable: true));
        notesControllers.add(PairNL(
            HandSignatureControl(
              threshold: 1.0,
              smoothRatio: 0.65,
              velocityRange: 2.0,
            ), [ScrollController(), ScrollController()]));
        counterLines.add(List.empty(growable: true));
      }
      notes[dbNotes[i][0]].item1 = dbNotes[i][1];
    }

    var dbNotesText = await ctx.query("SELECT * FROM notesText");

    for (int i = 0; i < dbNotesText.length; i++) {
      var pos = dbNotesText[i][2].split(',');
      textFields[dbNotesText[i][0]].add(
        PairNL(
            PairNL(TextEditingController(text: dbNotesText[i][1]), FocusNode()),
            [double.parse(pos[0]), double.parse(pos[1])]),
      );
      counterLines[dbNotesText[i][0]]
          .add('\n'.allMatches(dbNotesText[i][1]).length + 1); // add line count
    }

    var dbNotesCanvas = await ctx.query('SELECT * FROM notesCanvas');

    for (int i= 0; i < dbNotesCanvas.length; i++) {
      notesControllers[dbNotesCanvas[i][0]].item1.importData(jsonDecode(dbNotesCanvas[i][1]));
    }
  });
  /*} catch (j) {
    print('notes $j');
  }*/
  setStateNeeded[5] = true;
}

Future<void> dbSetup() async {
  // establish database connection
  try {
    await connection.open();
  } catch (e) {
    print('couldn\'t connect to database because of: $e');
  }

  _readTasks();
  _readContacts();
  _readMessages();
  _readNotes();
}
