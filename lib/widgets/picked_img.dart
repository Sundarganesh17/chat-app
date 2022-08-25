import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class userPickedImage extends StatefulWidget {
  userPickedImage(this.picImgfn);
  final void Function(File pickimage) picImgfn;
  @override
  State<userPickedImage> createState() => _userPickedImageState();
}

class _userPickedImageState extends State<userPickedImage> {
  File _pickedImg;
  void _pickerImg() async {
    final picker = ImagePicker();
    final pickedImg = await picker.getImage(source: ImageSource.camera);
    final pickedImgFile = File(pickedImg.path);
    setState(() {
      _pickedImg = pickedImgFile;
    });
    widget.picImgfn(pickedImgFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: _pickedImg =
              null ? Color(Colors.grey.green) : FileImage(_pickedImg),
          radius: 40,
        ),
        FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            onPressed: _pickerImg,
            icon: Icon(Icons.image),
            label: Text('add image')),
      ],
    );
  }
}
