

import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth_bloc.dart';
import 'package:flutter_login/const.dart';
import 'package:flutter_login/event/auth_event.dart';
import 'dart:io';
import 'package:flutter_login/styles/my_button_style.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../models/user_model.dart';

class ProfileDetail extends StatefulWidget {
  UserModel userModel;
  ProfileDetail({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  late TextEditingController _name;
  late TextEditingController _dob;
  late TextEditingController _email;
  File? _imageFile;
  // final ImagePicker _imagePicker = ImagePicker();
  // void _pickImageBase64() async{
  //   final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
  //   if(image==null){
  //     return;
  //   }
  //   Uint8List imageByte = await image!.readAsBytes();
  //   String _base64 = base64.encode(imageByte);
  //   print(_base64);
  //
  // }
  DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  late bool change = false;
  void _showTimePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
      String dob = _dateFormat.format(selectedDateTime);
      _dob.text = dob;
    }
  }

  @override
  void initState() {
    _name = TextEditingController(text: widget.userModel.fullName);

    _dob = TextEditingController(text: widget.userModel.birthday.toString().split(' ')[0]);
    _email = TextEditingController(text: widget.userModel.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    change = !change;
                  });
                },
                icon: const Icon(Icons.create))
          ],
        ),
        body: Stack(children: [
          Container(
            color: Theme.of(context).primaryColor,
          ),
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(26),
                        topLeft: Radius.circular(26))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Profile',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    const Text(
                      'Please complete your profile',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: CachedNetworkImage(
                        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNI3kQLeYMnpy05PhEiuzS1rtRmNVL7VKvwcE4ACmQSQT1rRmUO5mHLyjH-mGHq0ueUQY&usqp=CAU",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, erro) => Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Name:'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: TextField(
                        controller: _name,
                        enabled: change,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(left: 20, ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Date of birth:'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: TextField(
                        onTap: change ? () => _showTimePicker() : null,
                        enabled: change,
                        controller: _dob,
                        showCursor: true,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Email:'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: TextField(
                        enabled: change,
                        controller: _email,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(left: 20, ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextButton(
                          style: myButtonStyle(140, 40),
                          onPressed: change? () {
                            context.read<AuthBloc>().add(UpdateProfileEvent(int.parse(widget.userModel.id), _name.text, _email.text, null, _dob.text));
                          }: null,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // TextButton(
                    //     style: myButtonStyle(140, 40),
                    //     onPressed:  () {
                    //       _pickImageBase64();
                    //       },
                    //     child: const Text(
                    //       'Save',
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 20),
                    //     ))
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
