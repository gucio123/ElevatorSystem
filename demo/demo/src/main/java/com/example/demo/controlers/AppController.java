package com.example.demo.controlers;

import com.example.demo.converters.ElevatorToElevatorStatusConverter;
import com.example.demo.models.Elevator;
import com.example.demo.models.ElevatorStatusModel;
import com.example.demo.models.SetDestinationRequestModel;
import com.example.demo.services.AppLoop;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;
import reactor.core.publisher.Flux;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;


@RestController
@RequestMapping("/api")
public class AppController {

    @Autowired
    AppLoop appLoop;

    @GetMapping
    public String hello() {
        return "Main page for now";
    }

    @PostMapping("/startSystem")
    public void startSystem(){
        appLoop.start();
    }

    @RequestMapping(value = "/call", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    public void call(@RequestBody SetDestinationRequestModel setDestinationRequestModel) {
        appLoop.getListOfElevators().get(setDestinationRequestModel.getElevatorId()).
                addCallDestination(setDestinationRequestModel.getDestinationFloor());
    }

    @PostMapping("/pickDestination")
    public void setDestination(@RequestBody SetDestinationRequestModel setDestinationRequestModel) {
        appLoop.getListOfElevators().get(setDestinationRequestModel.getElevatorId()).
                addPickedDestination(setDestinationRequestModel.getDestinationFloor());
    }


//    @GetMapping(value = "/getElevatorStatus", produces = MediaType.APPLICATION_STREAM_JSON_VALUE)
//    public Flux<List<ElevatorStatusModel>> streamJsonObjects() {
//        ObjectMapper objectMapper = new ObjectMapper();
//        objectMapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
//        return Flux.interval(Duration.ofSeconds(1)).map(i -> appLoop.getStatuses());
//    }

@GetMapping("/getElevatorStatus")
public ResponseEntity<List<ElevatorStatusModel>> getSystemStatus(){
    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    List<ElevatorStatusModel> returnedList = appLoop.getStatuses();
    return new ResponseEntity<>(returnedList, HttpStatus.OK);
}
}


