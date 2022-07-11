import '../chat/newChatPopup.dart';

class Contact {
  String name;
  String mail;
  String tel;
  String company;
  String team;

  Contact(this.name, this.tel, this.mail, this.company, this.team);
}

List <Contact> contacts = List.generate(15, (index) => Contact('tom$index', '3', 'dd', 'sa', 'project 6'));

newContact(name, tel, mail, company, team) {
  contacts.add(Contact(name, tel, mail, company, team));
  usableContacts.add(Contact(name, tel, mail, company, team));
}