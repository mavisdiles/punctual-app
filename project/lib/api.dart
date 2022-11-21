import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/information.dart';

class API {
  String baseUrl = "https://a68m4z8zgk.execute-api.ap-northeast-2.amazonaws.com/dev";
  final client = http.Client();

  Future<Information> fetchInformation(String group, String user_id) async {
    // var path = "/users/0";
    var path = "/users?group=${group}&user_id=${user_id}";
    // var path = "/users";
    var url = baseUrl + path;

    final response = await client.get(url); // http get 메소드로 리퀘스트를 보냅니다.

    var data = json.decode(utf8.decode(response.bodyBytes)); // utf8로 디코딩해야 한글이 깨지지 않습니다.
    
    return Information.fromJson(data['Item']);
  }
}
