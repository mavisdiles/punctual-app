class Information {
  int group;
  String user_name;
  int user_id;
  String location;
  String arrive_time;
  bool lateness;
  bool detection;

  Information({ required this.group, required this.user_name, required this.user_id, required this.location, required this.arrive_time, required this.lateness,required this.detection});

  Information.fromJson(Map<String, dynamic> json) : // json데이터를 클래스 형식으로 변환
        group = json['group'],
        user_name = json['user_name'],
        user_id = json['user_id'],
        location = json['location'],
        arrive_time = json['arrive_time'],
        lateness = json['lateness'],
        detection = json['detection'];
}