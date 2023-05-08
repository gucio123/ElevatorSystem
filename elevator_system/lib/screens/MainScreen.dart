import 'dart:async';
import 'dart:convert';

import 'package:elevator_system/models/ElevatorStatusModel.dart';
import 'package:elevator_system/widgets/ElevatorCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isRunning = false;

  final elevatorStatusURL =
      Uri.http('localhost:8080', '/api/getElevatorStatus');
  var systemStartURL = Uri.http('localhost:8080', '/api/startSystem');

  @override
  void initState() {
    super.initState();
  }

  void fetchDataPeriodically() {
    Timer.periodic(Duration(milliseconds: 500), (timer) async {
      listOfElevatorStatusModel = await fetchData();
      setState(() {});
    });
  }

  Future<List<ElevatorStatusModel>> fetchData() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Response response = await http.get(elevatorStatusURL, headers: headers);
    String json = response.body;
    return (jsonDecode(json) as List)
        .map((value) => ElevatorStatusModel.fromJson(value))
        .toList();
  }

  late List<ElevatorStatusModel> listOfElevatorStatusModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isRunning
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: 16,
                itemBuilder: ((context, index) =>
                    ElevatorCard(listOfElevatorStatusModel[index])))
            : ElevatedButton(
                child: Text("Press to Start the system"),
                onPressed: () async {
                  listOfElevatorStatusModel = await fetchData();
                  fetchDataPeriodically();
                  setState(() {
                    isRunning = true;
                  });
                },
              ));
  }
}
