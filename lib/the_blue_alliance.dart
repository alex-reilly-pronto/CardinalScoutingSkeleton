import 'dart:ffi';

import 'package:cardinal_scouting_app/auth/secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Event {
  final String name;
  final String startDate;

  Event(this.name, this.startDate);

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        startDate = json['start_date'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'start_date': startDate,
      };
}

Future<List<Event>> fetchEvents() async {
  final url =
      Uri.parse('https://www.thebluealliance.com/api/v3/events/2023/simple');
  final eventsResponse =
      await http.get(url, headers: {"X-TBA-Auth-Key": tbaApiKey});
  final eventsJsonData = eventsResponse.body;
  List<dynamic> parsedListJson = jsonDecode(eventsJsonData);
  List<Event> eventsList = List<Event>.from(
      parsedListJson.map<Event>((dynamic i) => Event.fromJson(i)));

  return eventsList;
}
