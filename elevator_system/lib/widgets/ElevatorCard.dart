import 'dart:convert';
import 'dart:html';

import 'package:elevator_system/models/ElevatorStatusModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ElevatorCard extends StatefulWidget {
  ElevatorStatusModel elevatorStatusModel;

  ElevatorCard(this.elevatorStatusModel);

  @override
  State<ElevatorCard> createState() => _ElevatorCardState();
}

class _ElevatorCardState extends State<ElevatorCard> {
  final callElevatorURL = Uri.http('localhost:8080', '/api/call');
  final pickElevatorURL = Uri.http('localhost:8080', '/api/pickDestination');

  final Map<String, String> headers = {'Content-Type': 'application/json'};

  final TextEditingController _callController = TextEditingController();
  final TextEditingController _pickController = TextEditingController();

  bool isEnabled() {
    if (widget.elevatorStatusModel.elevatorState == 'RIDING' ||
        widget.elevatorStatusModel.elevatorState == 'WAITING_TO_PICK')
      return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: TextField(
                      controller: _callController,
                      decoration: const InputDecoration(
                          labelText: "Zawołaj windę na piętro"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        Map data = {
                          "elevatorId": widget.elevatorStatusModel.id,
                          "destinationFloor": int.parse(_callController.text)
                        };
                        var body = json.encode(data);
                        await http.post(callElevatorURL,
                            body: body, headers: headers);
                      },
                      child: Text("Zawołaj windę"))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: TextField(
                      controller: _pickController,
                      decoration: const InputDecoration(
                          labelText: "Wybierz piętro docelowe"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                  ),
                  isEnabled()
                      ? TextButton(
                          onPressed: () async {
                            Map data = {
                              "elevatorId": widget.elevatorStatusModel.id,
                              "destinationFloor":
                                  int.parse(_pickController.text)
                            };
                            setState(() {
                              _pickController.clear();
                            });
                            var body = json.encode(data);
                            await http.post(pickElevatorURL,
                                body: body, headers: headers);
                          },
                          child: Text("Wciśnij przycisk w środku windy"))
                      : Text("Nie możesz wybrać piętra")
                ],
              )
            ],
          ),
          Column(
            children: [
              Text("Winda nr ${widget.elevatorStatusModel.id}"),
              Text(
                  "Aktualnie na pietrze : ${widget.elevatorStatusModel.currentFloor}"),
              Text("Cel windy ${widget.elevatorStatusModel.destinationFloor}"),
              Text("Status windy ${widget.elevatorStatusModel.elevatorState}")
            ],
          ),
        ],
      ),
    );
  }
}
