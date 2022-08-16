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

  void addItem() {
    if (contactList.length != contacts.length) {
      setState(() {
        contactList.addAll(
            contacts.sublist(contactList.length, contactList.length + 5));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    contactList.addAll(contacts.take(15));
    sortContactList(contactList);
  }

  @override
  Widget build(BuildContext context) {
    print(contactList.length);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Assessment"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            addItem();
          },
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (contactList.length == index) {
                  if (contactList.length == contacts.length) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: const Text(
                        "You have reached end of the list",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox();
                }
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
                          onPressed: shareContact,
                          icon: const Icon(Icons.share))
                    ],
                  ),
                );
              },
              itemCount: contactList.length + 1),
        ),
      ),
    );
  }
}
