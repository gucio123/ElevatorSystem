class ElevatorStatusModel {
  final int currentFloor;
  final int destinationFloor;
  final int id;
  final String elevatorState;

  ElevatorStatusModel({
    required this.currentFloor,
    required this.destinationFloor,
    required this.id,
    required this.elevatorState,
  });

  factory ElevatorStatusModel.fromJson(Map<String, dynamic> json) {
    return ElevatorStatusModel(
      currentFloor: json['currentFloor'],
      destinationFloor: json['destinationFloor'],
      id: json['id'],
      elevatorState: json['elevatorState'],
    );
  }
}
