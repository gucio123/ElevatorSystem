package com.example.demo.models;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class ElevatorStatusModel {
    int currentFloor;
    int destinationFloor;
    int id;
    ElevatorState elevatorState;

    public ElevatorStatusModel(int currentFloor, int destinationFloor, int id, ElevatorState elevatorState) {
        this.currentFloor = currentFloor;
        this.destinationFloor = destinationFloor;
        this.id = id;
        this.elevatorState = elevatorState;
    }
}
