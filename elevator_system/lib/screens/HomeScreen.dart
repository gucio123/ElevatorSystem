import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:elevator_system/models/DestinationRequestModel.dart';
import 'package:elevator_system/models/ElevatorStatusModel.dart';
import 'package:elevator_system/screens/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var systemStartURL = Uri.http('localhost:8080', '/api/startSystem');
  var elevatorStatusURL = Uri.http('localhost:8080', '/api/getElevatorStatus');
  var callElevatorURL = Uri.http('localhost:8080', '/api/call');
  Map<String, String> headers = {'Content-Type': 'application/json'};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  var response = await http.post(systemStartURL);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');
                },
                child: Text("Start System")),
            TextButton(
                onPressed: () async {
                  Map data = {"elevatorId": 1, "destinationFloor": 10};
                  var body = json.encode(data);
                  print(body);
                  var response = await http.post(callElevatorURL,
                      body: body, headers: headers);

                  print("${response.statusCode}");
                  print("${response.body}");
                },
                child: Text("Call Elevator")),
            TextButton(
                onPressed: () async {
                  // print("1");
                  // final request = Request(
                  //   'GET',
                  //   Uri.parse('http://localhost:8080/api/getElevatorStatus'),
                  // );
                  // var streamedResponse = await request.send();
                  // print("2");
                  // var response = await Response.fromStream(streamedResponse);
                  // print("3");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Text("Pick Floor")),
            TextButton(
                onPressed: () async {
                  Map<String, String> headers = {
                    'Content-Type': 'application/json'
                  };
                  Response response =
                      await http.get(elevatorStatusURL, headers: headers);
                  String json = response.body;
                  var test = (jsonDecode(json) as List)
                      .map((value) => ElevatorStatusModel.fromJson(value))
                      .toList();
                  print(json);
                  print(test[0]);
                },
                child: Text("Show Status"))
          ],
        ),
      ),
    );
  }
}
