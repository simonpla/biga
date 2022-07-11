import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/chat/newChatPopup.dart';
import 'package:aufgabenplaner/pages/contacts/newContactPopup/newContactPopup.dart';
import 'package:aufgabenplaner/pages/notes/notes.dart';
import 'package:aufgabenplaner/pages/notes/notesList/notesList.dart';
import 'package:aufgabenplaner/pages/tasks/kanban/kanban.dart';
import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:painter/painter.dart';
import '../../Theme/themes.dart';

Widget _buildOnPlus(buildId, context) {
  switch (buildId) {
    case 0:
      taskCards.add('new thing');
      tasks.add(List.empty(growable: true));
      editName.add(true);
      Navigator.pop(context);
      setStateNeeded[4] = true;
      break;
    case 1:
      return NewContactPopup();
    case 2:
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
            context: context, builder: (contextSD) => newChatPopup(contextSD));
      });
      break;
    case 3:
      newNote = true;
      notesControllers.add(PainterController());
      notesControllers[notesControllers.length - 1].thickness = 3.0;
      notesControllers[notesControllers.length - 1].backgroundColor = Colors.white;
      Navigator.pop(context);
      setStateNeeded[5] = true;
  }
  return SizedBox();
}

Widget buildLowerNavigation(context, scaffoldKey, buildId) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Row(
      children: [
        Container(
            height: 30,
            width: MediaQuery.of(context).size.width / 2 > 250
                ? (MediaQuery.of(context).size.width - 250) / 2 - 10
                : MediaQuery.of(context).size.width / 4 - 10),
        RowSuper(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColorL,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(19),
                  topLeft: Radius.circular(19),
                ),
              ),
              height: 40,
              width: MediaQuery.of(context).size.width / 2 > 250
                  ? 250
                  : MediaQuery.of(context).size.width / 2,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 > 250
                        ? 50
                        : MediaQuery.of(context).size.width / 10,
                    height: 10,
                  ),
                  Container(
                    child: IconButton(
                      icon: menuIcon,
                      onPressed: () => scaffoldKey.currentState!.openDrawer(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 > 250
                        ? 50
                        : MediaQuery.of(context).size.width / 10,
                    height: 10,
                  ),
                  Container(
                    child: IconButton(
                      icon: searchIcon,
                      onPressed: () => null,
                    ),
                  ),
                ],
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => _buildOnPlus(buildId, context));
              },
              child: plusIcon,
              backgroundColor: buttonColor,
            ),
          ],
          innerDistance: -8,
        ),
      ],
    ),
  );
}
