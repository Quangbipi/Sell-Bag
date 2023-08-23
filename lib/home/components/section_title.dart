import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/tab_bloc.dart';
import 'package:flutter_login/event/tab_event.dart';

class SectionTitle extends StatelessWidget {
  String title;
  int check;
  SectionTitle({Key? key, required this.title, required this.check}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            InkWell(
              onTap: (){
                if(check ==1){
                  context.read<TabBloc>().add(TabChange(indextInput: 1));
                }
                if(check==0){
                  context.read<TabBloc>().add(TabChange(indextInput: 2));
                }
              },
              child: Text(
                "See more",
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16
                ),
              ),
            )
          ],
        ),

    );

  }
}
