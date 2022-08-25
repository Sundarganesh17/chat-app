import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/authform.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String username, String password,
      bool islogin, BuildContext ctx, File pickedImg) async {
    UserCredential authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (islogin) {
        final authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
            
        await FirebaseFirestore.instance
            .collection('user')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on PlatformException catch (error) {
      var msg = 'error occured ';
      if (error.message != null) {
        msg = error.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        islogin = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, isLoading));
  }
}
