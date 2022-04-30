import 'dart:async';
import 'package:aufgabenplaner/pages/popuptask/popuptask_func.dart';
import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';

var groups = ['project 1', 'project 2', 'project 3', 'project 4', 'project 6', 'project 5'];
List<String> filtered_items = [...groups]; // clone items
var _itemColor = List<Color?>.generate(groups.length, (index) => Colors.purple[300]); // no consideration if groups get added on runtime
var _setStateNeededPopUp = false;

class TaskGroup extends StatefulWidget {
  var org_context;

  TaskGroup(this.org_context, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TaskGroupState();
}

class TaskGroupState extends State<TaskGroup> {
  Timer? _asigneeTimer;

  @override
  void dispose() {
    _asigneeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.only(left: MediaQuery
                  .of(widget.org_context)
                  .size
                  .width / 4, right: MediaQuery
                  .of(widget.org_context)
                  .size
                  .width / 4),
              backgroundColor: menuBackgroundL,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: StatefulBuilder(
                  builder: (context, setState) {
                    _checkSetState() {
                      if (_setStateNeededPopUp == true) {
                        setState(() {
                          _setStateNeededPopUp = false;
                        });
                      }
                    }

                    _asigneeTimer = Timer.periodic(
                        Duration(milliseconds: 1), (Timer t) =>
                        _checkSetState());

                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: _buildListView(context),
                    );
                  }
              ),
            );
          },
        );
      },
      child: Text("task group"),
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
        groups.forEach((element) {
          if (value == "") {
            filtered_items.add(element);
          } else {
            if (element.toLowerCase().contains(value.toLowerCase())) {
              filtered_items.add(element);
            }
          }
        });
        _setStateNeededPopUp = true;
      },
    );
  }
}

Widget _buildRow(index) {
return SizedBox(
      height: 32,
      child: Padding(
        padding: EdgeInsets.only(right: 10, top: 3, bottom: 3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _itemColor[index],
          ),
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.only(left: 6, top: 3, bottom: 3),
              child: Text(
                filtered_items[index],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {

            },
            onHover: (_isHover) {
              _isHover ? _itemColor[index] = Colors.purple[500] : _itemColor[index] = Colors.purple[300];
              _setStateNeededPopUp = true;
            },
          ),
        ),
      ),
  );
}