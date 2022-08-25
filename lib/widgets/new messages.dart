import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newMeesaages extends StatefulWidget {
  @override
  State<newMeesaages> createState() => _newMeesaagesState();
}

class _newMeesaagesState extends State<newMeesaages> {
  String _enteredmsg;
  final _controller = new TextEditingController();
  void _sendmsg() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredmsg,
      'createdAt': Timestamp.now(),
      'userid': user.uid,
      'username': userdata['username'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                label: Text(
                  'new messages..',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _enteredmsg = val;
                });
              },
            ),
          ),
          IconButton(
              onPressed: _enteredmsg.trim().isEmpty ? null : _sendmsg,
              icon: Icon(Icons.send)),
        ],
      ),
    );
  }
}
