import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/information.dart';

class API {
  String baseUrl = "https://82q6vwk099.execute-api.ap-northeast-2.amazonaws.com/dev";
  String rpiUrl = "https://ip3aw35dt5p2dwmsh2nyfmg76e0ncpfk.lambda-url.us-east-1.on.aws/";
  final client = http.Client();

  Future<Information> fetchInformation(String group, String user_id) async {

    var path = "/users?group=${group}&user_id=${user_id}";
    var url = baseUrl + path;

    final response = await client.get(url); // http get 메소드로 리퀘스트를 보냅니다.

    var data = json.decode(utf8.decode(response.bodyBytes)); // utf8로 디코딩해야 한글이 깨지지 않습니다.
    
    return Information.fromJson(data['Item']);
  }

  Future sendInformation(String group, String user_id, String arrive_time) async {

    var path = "/users?group=${group}&user_id=${user_id}&arrive_time=${arrive_time}";
    var url = baseUrl + path;

    final response = await http.post(url); // http post 메소드로 리퀘스트를 보냅니다.
    print("try update db");
    print(json.decode(utf8.decode(response.bodyBytes)));
  }

  //장난 신호 Rpi로 전달
  Future toRpi(num user_id, bool led, bool spk) async {
    //var url = rpiUrl;
    var url = "https://82q6vwk099.execute-api.ap-northeast-2.amazonaws.com/dev/test";
    //var data ={};

    var data = Rpi(user_id,led,spk);
    var toJson = data.ToJson();

    var body = json.encode(toJson);

    try {
      /*
      final response = await http.get(url);
      */
      final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body); // http post 메소드로 리퀘스트를 보냅니다.

      var data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
    }catch(e){
      print(e);
    };

  }
}

class Rpi{
  num rpi_num = 0;
  bool led = false;
  bool spk = false;

  Rpi(this.rpi_num,this.led,this.spk);

  Map<String,dynamic> ToJson() =>
      {
        'rpi_num':rpi_num,
        'task':"trick",
        'body':{
          'led':led,
          'spk':spk,
          'message':"test message"
        },
      };
}
