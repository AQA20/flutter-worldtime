import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(timezone: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(
        timezone: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(timezone: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(
        timezone: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(
        timezone: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(
        timezone: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(
        timezone: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(
        timezone: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  String error = '';
  void updateTime(int index) async {
    WorldTime worldTime = locations[index];
    try {
      await worldTime.getTime();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      if (mounted) {
        Navigator.pop(context, {'worldTime': worldTime});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return error.isNotEmpty
        ? Center(child: Text(error))
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: Text('Choose a Location'),
              elevation: 0,
            ),
            body: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 4.0),
                  child: Card(
                      child: ListTile(
                          onTap: () {
                            updateTime(index);
                          },
                          title: Text(locations[index].location),
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/${locations[index].flag}'),
                          ))),
                );
              },
            ));
  }
}
