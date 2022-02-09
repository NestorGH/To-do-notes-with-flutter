import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/main.dart';

class AddNote extends StatelessWidget {
  //const AddNote({Key? key}) : super(key: key);
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              });
            },
            child: const Text(
              "Save",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: TextField(
              controller: title,
              decoration: const InputDecoration(
                hintText: 'title',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: content,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'content',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
