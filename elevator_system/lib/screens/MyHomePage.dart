import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../models/ElevatorStatusModel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<List<ElevatorStatusModel>> getStatusStream() async* {
    print("1");
    final request = Request(
      'GET',
      Uri.parse('http://localhost:8080/api/getElevatorStatus'),
    );
    var streamedResponse = await request
        .send()
        .then((value) => print("s"))
        .catchError((error) => print(error));
    // print("2");
    // var response = await Response.fromStream(streamedResponse);
    // print("3");
    // final data = jsonDecode(response.body) as List;
    // final statuses = data.map((e) => ElevatorStatusModel.fromJson(e)).toList();
    // yield statuses;
  }

  // var response = await http.Response.fromStream(responseStream);
  // print(response);
  // print(responseStream.toString());
  // await for (final chunk in responseStream.stream
  //     .transform(utf8.decoder)
  //     .transform(json.decoder)) {
  //   dynamic jsonResponse = chunk;
  //   List<ElevatorStatusModel> newData = [];
  //   print(jsonResponse);
  //   for (var item in jsonResponse!['data']) {
  //     print(item);
  //     newData.add(ElevatorStatusModel.fromJson(item));
  //   }
  //   yield newData;
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Elevator Status"),
      ),
      body: StreamBuilder<List<ElevatorStatusModel>>(
        stream: getStatusStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ElevatorStatusModel>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('Not connected to the stream');
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final status = data[index];
                    return ListTile(
                      title: Text('Elevator ${status.id}'),
                      subtitle: Text(
                          'Current floor: ${status.currentFloor}, destination floor: ${status.destinationFloor}, state: ${status.elevatorState}'),
                    );
                  },
                );
            }
          }
        },
      ),
    );
  }
}
