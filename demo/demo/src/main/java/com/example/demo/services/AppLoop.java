package com.example.demo.services;

import com.example.demo.converters.ElevatorToElevatorStatusConverter;
import com.example.demo.models.Elevator;
import com.example.demo.models.ElevatorStatusModel;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class AppLoop extends Thread{

    private final List<Elevator> listOfElevators;
    public AppLoop() {
        this.listOfElevators = new ArrayList<Elevator>(Arrays.asList(new Elevator(0), new Elevator(1),
                new Elevator(2), new Elevator(3), new Elevator(4), new Elevator(5),
                new Elevator(6), new Elevator(7), new Elevator(8), new Elevator(9),
                new Elevator(10), new Elevator(11), new Elevator(12), new Elevator(13),
                new Elevator(14), new Elevator(15)));
    }

    @Override
    public void run() {
        super.run();
        for (Elevator elevator : listOfElevators){
            elevator.start();
        }
    }

    public List<ElevatorStatusModel> getStatuses(){
        ArrayList<ElevatorStatusModel> returnedList = new ArrayList<>();
        for (Elevator elevator : this.listOfElevators)
            returnedList.add(ElevatorToElevatorStatusConverter.convert(elevator));
        return returnedList;
    }

    public List<Elevator> getListOfElevators() {
        return listOfElevators;
    }
}
