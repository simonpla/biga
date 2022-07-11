import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/chat/chatFunc.dart';
import 'package:flutter/material.dart';
import '../contacts/contactsFunc.dart';

List<Contact> usableContacts = [...contacts];
List<Contact> filteredContacts = [...usableContacts];

Widget newChatPopup(context) {
  if (filteredContacts != usableContacts) {
    filteredContacts = usableContacts;
  }

  return Dialog(
    child: Container(
      padding: EdgeInsets.all(10),
      height: filteredContacts.length * 32,
      child: Column(
        children: [
          SizedBox(
            height: 50,
              child: _search(context),
          ),
          Expanded(child: _showFiltered(context)),
        ],
      ),
    ),
  );
}

Widget _search(context) {
  return TextField(
    decoration: InputDecoration(
      prefixIcon: searchIcon,
      suffixIcon: IconButton(
        icon: closeIcon,
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
      hintText: 'search',
    ),
    onChanged: (value) {
      filteredContacts.clear();
      contacts.forEach((element) {
        if (value == '') {
          filteredContacts.add(element);
        } else {
          if (element.name.toLowerCase().contains(value.toLowerCase())) {
            filteredContacts.add(element);
          }
        }
      });
      setStateNeeded[3] = true;
    },
  );
}

Widget _showFiltered(alertContext) {
  return ListView.builder(
    itemCount: filteredContacts.length,
      itemBuilder: (context, indexSF) {
        return SizedBox(
          height: 32,
          child: InkWell(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                filteredContacts[indexSF].name,
              ),
            ),
            onTap: () {
              addChat(idCounter, filteredContacts[indexSF].name);
              idCounter++;
              Navigator.pop(alertContext);
              Navigator.pop(alertContext);
              usableContacts.remove(filteredContacts[indexSF]);
              setStateNeeded[3] = true;
            },
          ),
        );
      }
  );
}