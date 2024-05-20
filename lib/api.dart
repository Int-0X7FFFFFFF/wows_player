import 'package:dio/dio.dart';
import 'package:wows_player/user_setting.dart';

var dio = Dio();
var userSetting = UserSetting();

apiShipExp() async {
  var url = 'https://api.wows-numbers.com/personal/rating/expected/json/';
  Response response;
  response = await dio.get(url);
  var res = response.data;
  return res;
}

apiShipList() async {
  var api =
      'https://raw.githubusercontent.com/Int-0X7FFFFFFF/wows_info_flutter/master/lib/json/wows_ship_list.json';
  var dio = Dio();
  Response response;
  response = await dio.get(api);
  return response.data.toString();
}
