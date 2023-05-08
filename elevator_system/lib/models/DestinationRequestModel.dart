class DestinationRequestModel {
  int elevatorId;
  int destinationFloor;

  DestinationRequestModel(this.elevatorId, this.destinationFloor);

  Map<String, int> toJson() => {
        "elevatorId": elevatorId,
        "destinationFloor": destinationFloor,
      };
}
