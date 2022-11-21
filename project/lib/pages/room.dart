import 'package:flutter/material.dart';
import 'package:project/model/information.dart';

import 'package:project/api.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  static const routeName = "/room";
  final String title;
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            for(num i=0; i<5; i++)
              loadInformation
                  ? FutureBuilder<Information>(
                future: widget.api.fetchInformation("0", "${i}"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) { //데이터가 정상적일때
                    Information? information = snapshot.data;
                    print(information?.lateness);
                    return informationView(information!);
                  }
                  else { //데이터가 비정상일 때
                    return Text("no data!");
                  }
                },
              )
                  : Text("NULL"),//상관없이 반환
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
        Text("사용자 불러오기")
        //Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget informationView(Information information) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      //padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 9.0),
      child:
      Row(children: <Widget>[
          if (information.lateness == false)...[
            Image.asset("imgs/person-icon.png",width:50)
          ],
          if (information.lateness == true)...[
            Image.asset("imgs/person-icon2.png",width:50)
          ],
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("사용자 이름 : ${information.user_name}"),
              if (information.lateness == false)...[
                Text("지각여부 : 여유")
              ],
              if (information.lateness == true)...[
                Text("지각여부 : 지각")
              ]
            ],
          )
        ]
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}