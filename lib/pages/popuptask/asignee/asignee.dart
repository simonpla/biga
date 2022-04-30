import 'dart:async';
import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';

var items = ['hi', 'tomtom', 'yeeeah', 'hi2', 'tomtom2', 'yeeeah2'];
List<String> filtered_items = [...items]; // clone items

class Asignee extends StatefulWidget {
  var org_context;

  Asignee(this.org_context, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AsigneeState();
}

class AsigneeState extends State<Asignee> {
  var _setStateNeededPopUp = false;
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
              insetPadding: EdgeInsets.only(left: MediaQuery.of(widget.org_context).size.width / 4, right: MediaQuery.of(widget.org_context).size.width / 4),
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
                      Duration(milliseconds: 1), (Timer t) => _checkSetState());

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
      child: Text("asignee"),
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
        return _buildRow(filtered_items[index - 1]);
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
        items.forEach((element) {
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

  Widget _buildRow(String c) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 6, right: 10, top: 5, bottom: 5),
        height: 32,
        child: Text(
          c,
          style: TextStyle(
            fontSize: 16,
            color: uTextColor,
          ),
        ),
      ),
      onTap: () {

      },
    );
  }
}
