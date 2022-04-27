import 'dart:async';
import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';

var items = ['hi', 'tomtom', 'yeeeah', 'hi2', 'tomtom2', 'yeeeah2'];
List<String> filtered_items = [...items]; // clone items

class Asignee extends StatefulWidget {
  const Asignee({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AsigneeState();
}

class AsigneeState extends State<Asignee> {
  var _setStateNeededPopUp = false;
  Timer? _asigneeTimer;

  @override
  void initState() {
    super.initState();
    _asigneeTimer =
        Timer.periodic(Duration(microseconds: 1), (Timer t) => _checkSetState());
  }

  @override
  void dispose() {
    _asigneeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        color: menuBackgroundL,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        itemBuilder: (context) {
          return _buildListView(context);
        });
  }

  List<PopupMenuItem<int>> _buildListView(org_context) {
    return List.generate(
      filtered_items.length + 1,
      (index) {
        return PopupMenuItem(
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            if (index == 0) {
              // search as first item
              return _search(org_context);
            }
            return _buildRow(filtered_items[index - 1]);
          }),
        );
      },
    );
  }

  PopupMenuEntry<int> _search(context) {
    return PopupMenuItem(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
      }),
    );
  }

  PopupMenuEntry<int> _buildRow(String c) {
    return PopupMenuItem(
      child: Text(
        c,
      ),
    );
  }

  _checkSetState() {
    if (_setStateNeededPopUp == true) {
      setState(() {
        _setStateNeededPopUp = false;
      });
      print('rebuilt');
    }
  }
}
