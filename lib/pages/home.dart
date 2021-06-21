import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WorldTime data;

  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    data = (ModalRoute.of(context)!.settings.arguments as Map)['worldTime'];

    // set background
    String bgImage = data.isDaytime ? 'day.png' : 'night.png';
    Color? bgColor = data.isDaytime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.edit_location, color: Colors.grey[300]),
                  label: Text('Edit Location',
                      style: TextStyle(color: Colors.grey[300])),
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');

                    setState(() {
                      //data = result['worldTime'];

                      data.location = result['worldTime'].location;
                      data.time = result['worldTime'].time;
                      data.isDaytime = result['worldTime'].isDaytime;
                    });
   
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data.location,
                      style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(data.time,
                    style: TextStyle(
                      fontSize: 50.00,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
