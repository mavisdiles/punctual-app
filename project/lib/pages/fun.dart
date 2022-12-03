import 'package:flutter/material.dart';
import 'package:project/api.dart';

class Fun extends StatelessWidget {
  num user_id = 0;
  String user_name="";
  Fun(this.user_id,this.user_name,{Key? key}) : super(key: key);

  API api = API();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('벌주기 페이지'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("imgs/home.png",width:200),
            Text(user_name,style: TextStyle(fontSize: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('소리내기',style: TextStyle(fontSize: 20)),
                  onPressed:(){
                    api.toRpi(user_id,false,true);
                    print("send speaker to Rpi..");
                  },
                ),
                ElevatedButton(
                  child: Text('LED 켜기',style: TextStyle(fontSize: 20)),
                  onPressed:(){
                    api.toRpi(user_id,true,false);
                    print("send LED to Rpi..");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}