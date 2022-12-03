import 'package:flutter/material.dart';
import 'package:project/api.dart';
import 'package:project/pages/room.dart';

class Login extends StatelessWidget {
  API api = API();

  String GroupNum = "0";
  String MyNum = "0";

  String totaltime ="00:43";
  String arrivetime = "17:43";
  String dtime = "18:00";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 페이지'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('시작'),
          onPressed:(){
            api.sendInformation(GroupNum, MyNum, arrivetime); //group,user_id,arrive_time
            //Navigator.pushNamed(context, '/room');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(dtime:dtime)
                )
            );
          },
        ),
      ),
    );
  }
}