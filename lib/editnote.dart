import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/home.dart';

class EditNote extends StatefulWidget {
  //EditNote({Key? key}) : super(key: key);

  DocumentSnapshot docid;
  EditNote({required this.docid});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docid.get('title'));
    content = TextEditingController(text: widget.docid.get('content'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              });
            },
            child: const Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              });
            },
            child: const Text("delete"),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: TextField(
              controller: title,
              decoration: const InputDecoration(
                hintText: 'Title',
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
                  hintText: 'Content',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
