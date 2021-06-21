import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String _baseUrl = 'http://worldtimeapi.org/api/timezone/';
  late String location;
  late String flag;
  late String time;
  late String error = '';
  late String timezone;
  late bool isDaytime;
  bool dataFetched = false;
  bool hasError = false;

  WorldTime(
      {required this.location, required this.timezone, required this.flag});

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse(_baseUrl + timezone));
      Map data = jsonDecode(response.body);
      String offset = data['utc_offset'].substring(0, 3);
      DateTime now = DateTime.parse(data['datetime']);
      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      dataFetched = true;
      hasError = false;
    } catch (e) {
      dataFetched = false;
      hasError = true;
      print(e.toString());
      error = e.toString();
    }
  }
}
