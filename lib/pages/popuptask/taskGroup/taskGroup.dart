import 'dart:async';
import 'package:aufgabenplaner/pages/popuptask/asignee/asignee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../../../main.dart';

class Pair<T1, T2> {
  T1 item1;
  T2 item2;

  Pair(this.item1, this.item2);
}

List<Pair<String, Color?>> groups = [
  Pair<String, Color?>('project 1', Colors.deepPurpleAccent[200]),
  Pair<String, Color?>('project 2', Colors.deepPurpleAccent[200]),
  Pair<String, Color?>('project 3', Colors.deepPurpleAccent[200]),
  Pair<String, Color?>('project 4', Colors.deepPurpleAccent[200]),
  Pair<String, Color?>('project 5', Colors.deepPurpleAccent[200]),
  Pair<String, Color?>('project 6', Colors.deepPurpleAccent[200]),
];
List<Pair<String, Color?>> filtered_groups = [...groups]; // clone items
List<Pair<String, Color?>> used_groups = [];

class TaskGroup extends StatefulWidget {
  final org_context;
  var projectGroups;
  var filteredProjectGroups;
  var usedProjectGroups;
  var setStateParent;
  var _setStateNeededPopUp = false;
  var _firstBuildRun = true;

  TaskGroup(this.org_context, this.projectGroups, this.filteredProjectGroups,
      this.usedProjectGroups, this.setStateParent,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TaskGroupState();
}

class TaskGroupState extends State<TaskGroup> {
  Timer? _asigneeTimer;

  @override
  void initState() {
    super.initState();
  }

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
                Text("task groups"),
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
                    child: StatefulBuilder(builder: (context, setState) {
                      checkSetState() {
                        if (widget._setStateNeededPopUp == true) {
                          setState(() {
                            widget._setStateNeededPopUp = false;
                          });
                        }
                      }

                      if (widget._firstBuildRun && this.mounted) {
                        _asigneeTimer = Timer.periodic(
                            Duration(microseconds: 1),
                            (Timer t) =>
                                checkSetState()); // check if the stateful widget is mounted and it's the first run, if yes call the setState checker
                        widget._firstBuildRun = false;
                      }

                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: _buildListView(context),
                      );
                    }),
                  );
                },
              ).then((_) {
                _asigneeTimer?.cancel();
                widget._firstBuildRun = true;
                setStateNeeded[widget.setStateParent] = true;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 7),
            child: _showUsedGroups(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(org_context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.filteredProjectGroups.length + 1,
      itemBuilder: (context, indexBLW) {
        if (indexBLW == 0) {
          // search as first item
          return Column(
            children: [
              _search(org_context),
              SizedBox(height: 7),
            ],
          );
        }
        return _buildRow(indexBLW - 1);
      },
    );
  }

  Widget _search(context) {
    return TextField(
      style: TextStyle(color: uTextColor),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        border: Theme.of(context).inputDecorationTheme.border,
        focusedBorder: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.border,
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
        widget.filteredProjectGroups.clear(); // remove everything
        widget.projectGroups.forEach((element) {
          if (value == "") {
            widget.filteredProjectGroups.add(element);
          } else {
            if (element.item1.toLowerCase().contains(value.toLowerCase())) {
              widget.filteredProjectGroups.add(element);
            }
          }
        });
        widget._setStateNeededPopUp = true;
      },
    );
  }

  Widget _buildRow(indexBR) {
    return SizedBox(
      height: 32,
      child: Padding(
        padding: EdgeInsets.only(right: 10, top: 3, bottom: 3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.filteredProjectGroups[indexBR].item2,
          ),
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.only(left: 6, top: 3, bottom: 3),
              child: Text(
                widget.filteredProjectGroups[indexBR].item1,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              widget.usedProjectGroups.add(Pair<String, Color?>(
                  widget.filteredProjectGroups[indexBR].item1,
                  Colors.deepPurpleAccent[200]));
              setStateNeeded[widget.setStateParent] = true;
              items.remove(widget.filteredProjectGroups[indexBR]);
              widget.filteredProjectGroups.removeAt(indexBR);
              widget._setStateNeededPopUp = true;
            },
            onHover: (_isHover) {
              _isHover
                  ? widget.filteredProjectGroups[indexBR].item2 =
              Colors.deepPurpleAccent[400]
                  : widget.filteredProjectGroups[indexBR].item2 =
              Colors.deepPurpleAccent[200];
              widget._setStateNeededPopUp = true;
            },
          ),
        ),
      ),
    );
  }

  Widget _showUsedGroups() {
    return SizedBox(
      height: 32.0 * widget.usedProjectGroups.length,
      width: 300,
      child: ListView.builder(
        itemCount: widget.usedProjectGroups.length,
        itemBuilder: (context, indexSUG) {
          return SizedBox(
            height: 32,
            child: Padding(
              padding: EdgeInsets.only(right: 10, top: 3, bottom: 3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.usedProjectGroups[indexSUG].item2,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 6, top: 3, bottom: 3, right: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.usedProjectGroups[indexSUG].item1,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.projectGroups
                              .add(widget.usedProjectGroups[indexSUG]);
                          widget.filteredProjectGroups
                              .add(widget.usedProjectGroups[indexSUG]);
                          widget.usedProjectGroups.removeAt(indexSUG);
                          setStateNeeded[widget.setStateParent] = true;
                        },
                        child: Icon(
                          Icons.close,
                          size: 15,
                          color: uTextColor,
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
}
