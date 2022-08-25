import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/bubble%20message.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(
          FirebaseAuth.instance.currentUser,
        ),
        builder: (ctx, futuresnapshot) {
          if (futuresnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy(
                    'createdAt',
                    descending: true,
                  )
                  .snapshots(),
              builder: (ctx, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chatDoc = snapshots.data.docs;
                return ListView.builder(
                    reverse: true,
                    itemCount: chatDoc.length,
                    itemBuilder: (ctx, index) => bubbleMessages(
                          chatDoc[index]['text'],
                          chatDoc[index]['userid'] == futuresnapshot.data.uid,
                          chatDoc[index]['username'],
                          key: ValueKey(chatDoc[index].documentId),
                        ));
              });
        });
  }
}
