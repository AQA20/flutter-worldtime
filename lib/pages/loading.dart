import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late WorldTime worldTime;
  String error = '';

  void setupWorlTime() async {
    WorldTime worldTime = WorldTime(
        timezone: 'Asia/Amman', location: 'Amman', flag: 'jordan.jpg');
    try {
      await worldTime.getTime();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: {'worldTime': worldTime});
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorlTime();
  }

  @override
  Widget build(BuildContext context) {
    return error.isNotEmpty
        ? Center(child: Text(error))
        : Scaffold(
            backgroundColor: Colors.blue[900],
            body: Center(
              child: SpinKitCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ));
  }
}
