package com.example.demo.models;

import jakarta.annotation.Nullable;
import lombok.SneakyThrows;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Elevator extends Thread{
    private int id;
    private int currentFloor;
    private int destinationFloor;
    private List<DestinationFloor> destinations;
    private ArrayList<Integer> stops;
    private ElevatorState elevatorState;
    private boolean isMoving = false;
    public Elevator(int id) {
        this.id = id;
        this.currentFloor = 0;
        this.destinationFloor = 0;
        this.destinations = new ArrayList<DestinationFloor>(List.of(new DestinationFloor(0)));
        this.stops = new ArrayList<Integer>();
        this.elevatorState = ElevatorState.RIDING;
    }

    @SneakyThrows
    @Override
    public void run() {
        while(true){
            switch (elevatorState) {
                case STANDING:
                    if(!destinations.isEmpty()) {
                        pickDestination();
                        this.elevatorState = ElevatorState.RIDING;
                    }
                    break;
                case RIDING :
                    moveElevator();
                    break;
                case WAITING_TO_PICK:
                    System.out.println("czekam");
                    Thread.sleep(5000);
                    this.elevatorState = ElevatorState.STANDING;
                    break;
            }
            if(this.elevatorState == ElevatorState.RIDING)
            System.out.println("elevator " + id + " pietro" + currentFloor);
            Thread.sleep(1000);
        }
    }

    private void moveElevator() {
        if(!stops.isEmpty()){
            this.currentFloor = stops.get(0);
            stops.remove(0);
        }
        else {
            if(this.currentFloor == this.destinationFloor) {

                destinations.removeAll(destinations.stream().
                        filter(destinationFloor1 -> (destinationFloor1.getDestinationFloor() == destinationFloor)).
                        toList());
                
                destinationFloor = -1;
                System.out.println("dojechala");
                this.elevatorState = ElevatorState.WAITING_TO_PICK;
            }
        }
    }

    @Override
    public long getId() {
        return id;
    }

    public ElevatorState getElevatorState() {
        return elevatorState;
    }

    public int getCurrentFloor() {
        return currentFloor;
    }

    public int getDestinationFloor() {
        return destinationFloor;
    }

    public ArrayList<Integer> getStops() {
        return stops;
    }

    public void pickDestination () {
        float min = Integer.MAX_VALUE;
        int pickedIndex = 0;
        float distance;
        for (int i = 0; i < destinations.size() - 1; i++) {
            destinations.get(i).setPriority(destinations.get(i).getPriority() + 1);
            distance = Math.abs(currentFloor - destinations.get(i).getDestinationFloor()) / destinations.get(i).getPriority();
            if (distance < min) {
                min = distance;
                pickedIndex = i;
            }
        }
        this.stops.clear();
        setDestinationFloor(this.destinations.get(pickedIndex).getDestinationFloor());
    }

    public void addCallDestination (int destinationFloor) {
        destinations.add(new DestinationFloor(destinationFloor));
    }

    public void addPickedDestination (int destinationFloor) {
        destinations.add(new DestinationFloor(destinationFloor, 2));
    }

    public void setDestinationFloor(int destinationFloor) {
        this.destinationFloor = destinationFloor;
        int i = currentFloor;

        if(destinationFloor >= currentFloor)
            for(int x = i + 1; x <=destinationFloor; x++)
                stops.add(x);
        else
            for(int y = i - 1; y >= destinationFloor; y--)
                stops.add(y);
    }

    public void setStops(ArrayList<Integer> stops) {
        this.stops = stops;
    }
}
