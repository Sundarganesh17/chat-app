import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chats.dart';
import 'package:flutter_complete_guide/widgets/new%20messages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter chat'),
        actions: <Widget>[
          DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.logout,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('LOGOUT')
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemidendifier) {
                if (itemidendifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[Expanded(child: Messages()), newMeesaages()],
        ),
      ),
    );
  }
}
