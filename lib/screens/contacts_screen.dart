import 'package:flutter/material.dart';
import 'package:flutter_assessment/dummy_data.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Map<String, String>> contactList = [];

  String convertTime(bool isTimeAgo, String dateTimeInString) {
    DateTime dateTime = DateTime.parse(dateTimeInString);
    if (isTimeAgo) {
      return timeago.format(dateTime);
    }
    return dateTimeInString;
  }

  void shareContact() {}

  void sortContactList(List<Map<String, String>> cList) {
    cList.sort((a, b) {
      return (b['check-in'] as String).compareTo(a['check-in'] as String);
    });
  }

  @override
  void initState() {
    super.initState();
    contactList.addAll(contacts);
    sortContactList(contactList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Assessment"),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(contactList[index]["user"].toString()),
                subtitle: Text(contactList[index]["phone"].toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(convertTime(
                        true, contactList[index]["check-in"].toString())),
                    IconButton(
                        onPressed: shareContact, icon: const Icon(Icons.share))
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: contacts.length),
      ),
    );
  }
}
