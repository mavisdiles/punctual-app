import 'package:flutter/material.dart';
import 'package:project/model/information.dart';

import 'package:project/api.dart';
import 'package:project/time.dart';
import 'package:project/pages/fun.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.dtime}) : super(key: key);

  static const routeName = "/room";
  final String dtime;
  final String title="약속지미키";
  API api = API();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loadInformation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            timeView(context),
            Text("참여 멤버",style: TextStyle(fontSize: 20)),
            for(num i=0; i<5; i++)
              loadInformation
                  ? FutureBuilder<Information>(
                future: widget.api.fetchInformation("0", "${i}"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) { //데이터가 정상적일때
                    Information? information = snapshot.data;
                    //print(information?.lateness);
                    return informationView(information!);
                  }
                  else { //데이터가 비정상일 때
                    return Text("no data!");
                  }},) : Text(""),//상관없이 반환
            Text("",style: TextStyle(fontSize: 30))
          ],
        ),
      ),
      floatingActionButton: ElevatedButton( // 버튼을 누르면 데이터를 불러옵니다.
        onPressed: () {
          setState(() {
            loadInformation = true;
          });
        },
        child:
        Text("+ 새로 고침")
        //Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget informationView(Information information) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      //padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 9.0),
      child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          if (information.lateness == false && information.detection == false)...[
            Image.asset("imgs/person-icon.png",width:50)
          ],
          if (information.detection == true)...[
            Image.asset("imgs/person-icon3.png",width:50)
          ],
          if (information.lateness == true)...[
            Image.asset("imgs/person-icon2.png",width:50)
          ],
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("사용자 이름 : ${information.user_name}"),
              if (information.lateness == false && information.detection == false)...[
                Text("여유",style: TextStyle(color: Colors.green))
              ],
              if (information.detection == true)...[
                Text("출발 요망",style: TextStyle(color: Colors.orange))
              ],
              if (information.lateness == true)...[
                Text("지각",style: TextStyle(color: Colors.red))
              ]
            ],
          ),
          ElevatedButton( // 버튼을 누르면 데이터를 불러옵니다.
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Fun(information.user_id,information.user_name)
                    )
                );
              },
              child:
              Text("자세히")
          ),
        ]
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
          border: Border(

              bottom: BorderSide(
                color: Colors.black12,
                width: 1,
              )
          )
      )
    );
  }
}