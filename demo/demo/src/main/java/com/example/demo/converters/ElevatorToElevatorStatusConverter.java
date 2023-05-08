package com.example.demo.converters;

import com.example.demo.models.Elevator;
import com.example.demo.models.ElevatorStatusModel;

public class ElevatorToElevatorStatusConverter {
    public static ElevatorStatusModel convert(Elevator elevator) {
        return new ElevatorStatusModel(elevator.getCurrentFloor(), elevator.getDestinationFloor(),
                (int) elevator.getId(), elevator.getElevatorState());
    }
}
