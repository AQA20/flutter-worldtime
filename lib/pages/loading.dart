import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late WorldTime worldTime;

  void setupWorlTime() async {
    WorldTime worldTime = WorldTime(
        timezone: 'Asia/Amman', location: 'Amman', flag: 'jordan.jpg');
    await worldTime.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': worldTime.location,
      'flag': worldTime.flag,
      'isDaytime': worldTime.isDaytime,
      'time': worldTime.time,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorlTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ));
  }
}
