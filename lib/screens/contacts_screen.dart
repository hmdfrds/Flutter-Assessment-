import 'package:flutter/material.dart';
import 'package:flutter_assessment/dummy_data.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  void shareContact() {}
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
                title: Text(contacts[index]["user"].toString()),
                subtitle: Text(contacts[index]["phone"].toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(contacts[index]["check-in"].toString()),
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
