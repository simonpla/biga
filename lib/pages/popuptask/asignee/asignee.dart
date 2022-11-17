import 'dart:async';
import 'package:aufgabenplaner/pages/contacts/contactsFunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../../../main.dart';
import '../popuptask_func.dart';

var items = [...contacts];
List<Contact> filtered_items = [...items]; // clone items
List<Contact> used_items = [];
var _setStateNeededPopUp = false;
var _firstBuildRun = true;

class Asignee extends StatefulWidget {
  var org_context;

  Asignee(this.org_context, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AsigneeState();
}

class AsigneeState extends State<Asignee> {
  Timer? _asigneeTimer;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.blueGrey),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 3),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(CupertinoIcons.chevron_right, size: 22),
                ),
                Text("asignees"),
              ],
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.only(
                        left: MediaQuery.of(widget.org_context).size.width / 4,
                        right:
                            MediaQuery.of(widget.org_context).size.width / 4),
                    //backgroundColor: menuBackgroundL,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        checkSetState() {
                          if (_setStateNeededPopUp == true) {
                            setState(() {
                              _setStateNeededPopUp = false;
                            });
                          }
                        }

                        if (_firstBuildRun && this.mounted) {
                          _asigneeTimer = Timer.periodic(
                              Duration(microseconds: 1),
                              (Timer t) =>
                                  checkSetState()); // check if the stateful widget is mounted and it's the first run, if yes call the setState checker
                          _firstBuildRun = false;
                        }

                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: _buildListView(context),
                        );
                      },
                    ),
                  );
                },
              ).then((_) {
                _asigneeTimer?.cancel();
                _firstBuildRun = true;
                setStateNeeded[0] = true;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 7),
            child: _showUsedItems(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(org_context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filtered_items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // search as first item
          return Column(
            children: [
              _search(org_context),
              SizedBox(height: 7),
            ],
          );
        }
        return _buildRow(index - 1);
      },
    );
  }

  Widget _search(context) {
    return TextField(
      style: TextStyle(color: uTextColor),
      decoration: InputDecoration(
        border: Theme.of(context).inputDecorationTheme.border,
        focusedBorder: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.border,
        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        prefixIcon: searchIcon,
        suffixIcon: IconButton(
          icon: closeIcon,
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        hintText: "search",
      ),
      onChanged: (value) {
        filtered_items.clear(); // remove everything
        items.forEach((element) {
          if (value == "") {
            filtered_items.add(element);
          } else {
            if (element.name.toLowerCase().contains(value.toLowerCase())) {
              filtered_items.add(element);
            }
          }
        });
        _setStateNeededPopUp = true;
      },
    );
  }

  Widget _buildRow(indexBR) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 6, right: 10, top: 5, bottom: 5),
        height: 32,
        child: Text(
          filtered_items[indexBR].name,
          style: TextStyle(
            fontSize: 16,
            color: uTextColor,
          ),
        ),
      ),
      onTap: () {
        used_items.add(filtered_items[indexBR]);
        setStateNeeded[0] = true;
        items.remove(filtered_items[indexBR]);
        filtered_items.removeAt(indexBR);
        _setStateNeededPopUp = true;
      },
    );
  }
}

Widget _showUsedItems() {
  return SizedBox(
    height: 32.0 * used_items.length,
    width: 300,
    child: ListView.builder(
      itemCount: used_items.length,
      itemBuilder: (context, indexSUG) {
        return SizedBox(
          height: 32,
          child: Padding(
            padding: EdgeInsets.only(right: 10, top: 3, bottom: 3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 6, top: 3, bottom: 3, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      used_items[indexSUG].name,
                      style: TextStyle(
                        fontSize: 16,
                        color: uTextColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: InkWell(
                        onTap: () {
                          items.add(used_items[indexSUG]);
                          filtered_items.add(used_items[indexSUG]);
                          used_items.removeAt(indexSUG);
                          setStateNeeded[0] = true;
                        },
                        child: Icon(
                          Icons.close,
                          size: 15,
                          color: uTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
