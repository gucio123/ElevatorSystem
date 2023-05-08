package com.example.demo.models;

public class DestinationFloor {

    private int destinationFloor;
    private int priority;

    public DestinationFloor(int destinationFloor) {
        this.destinationFloor = destinationFloor;
        this.priority = 1;
    }

    public DestinationFloor(int destinationFloor, int priority) {
        this.destinationFloor = destinationFloor;
        this.priority = priority;
    }

    public int getDestinationFloor() {
        return destinationFloor;
    }

    public void setDestinationFloor(int destinationFloor) {
        this.destinationFloor = destinationFloor;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }
}
