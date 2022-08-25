import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/picked_img.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.authForm, this.isloading);
  final void Function(String email, String username, String password,
      bool islogin, BuildContext ctx, File img) authForm;
  bool isloading;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var isLogin = true;
  String _email = '';
  String _username = '';
  String _password = '';
  File _picimg;
  void _pickedimg(File pickimg) {
    _picimg = pickimg;
  }

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_picimg == null && !isLogin) {
      showDialog(
          context: context,
          builder: (ctx) => Text('plzz add your img'),
          barrierColor: Theme.of(context).primaryColor);
    }
    if (_isValid) {
      _formKey.currentState.save();
      widget.authForm(_email, _username, _password, isLogin, context, _picimg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!isLogin) userPickedImage(_pickedimg),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'plzz add crt syumbols';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _email = newValue;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text(
                      'Email address',
                    ),
                  ),
                ),
                if (!isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'plz add atleast 4 chracter';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _username = newValue;
                    },
                    decoration: InputDecoration(label: Text('username')),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'plzz enter atleast 7 chacters';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _password = newValue;
                  },
                  decoration: InputDecoration(label: Text('password')),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                if (widget.isloading) CircularProgressIndicator(),
                if (!widget.isloading)
                  RaisedButton(
                    onPressed: _trySubmit,
                    child: Text(isLogin ? 'login' : 'sign-up'),
                  ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin
                      ? 'create another account'
                      : 'ive already have account'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
