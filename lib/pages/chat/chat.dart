import 'dart:async';
import 'package:aufgabenplaner/pages/appBar/appBar.dart';
import 'package:aufgabenplaner/pages/chat/chatFunc.dart';
import 'package:aufgabenplaner/pages/chat/messageDisplay/messageDisplay.dart';
import 'package:aufgabenplaner/pages/chat/newMTextField/newMTextField.dart';
import 'package:aufgabenplaner/pages/chat/quickContacts/quickContacts.dart';
import 'package:aufgabenplaner/pages/chat/topInfoBar/topInfoBar.dart';
import 'package:aufgabenplaner/pages/menuDrawer/menuDrawer.dart';
import 'package:aufgabenplaner/pages/navigationbar/navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'dart:io';

var afterUpdatedMD = -1;

final newMessage = TextEditingController();

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(milliseconds: 1), (Timer t) => checkSetState());
  }

  @override
  void dispose() {
    timer?.cancel();
    newMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context),
      drawer: menuDrawer(context),
      body: chats.length < 1
          ? Container()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: Platform.isIOS ? 120 : 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 70),
                          topInfoBar(openedChat),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Theme.of(context).canvasColor
                                ],
                                stops: [0.995, 1],
                              ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstOut,
                            child: messages.length < 1
                                ? Container()
                                : messageDisplay(context, openedChat),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: newMessageTextField(context, openedChat),
                      ),
                    ],
                  ),
                ),
                //Spacer(),
                quickContacts(0),
                //Spacer(),
              ],
            ),
      floatingActionButton: buildLowerNavigation(context, scaffoldKey, 2),
    );
  }

  checkSetState() {
    if (setStateNeeded[3] == true) {
      setState(() {
        setStateNeeded[3] = false;
      });
    }
  }
}
