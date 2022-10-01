import '../../database/database.dart';
import '../chat/newChatPopup.dart';

class Contact {
  String name;
  String mail;
  String tel;
  String company;
  String team;

  Contact(this.name, this.tel, this.mail, this.company, this.team);
}

List <Contact> contacts = List.empty(growable: true);

newContact(name, tel, mail, company, team) async {
  contacts.add(Contact(name, tel, mail, company, team));
  usableContacts.add(Contact(name, tel, mail, company, team));
  await connection.transaction((connection) async {
    await connection.query(
      "INSERT INTO contacts VALUES (@a, @b, @c, @d, @e)",
      substitutionValues: {
        "a": name,
        "b": tel,
        "c": mail,
        "d": company,
        "e": team,
      }
    );
  });
}