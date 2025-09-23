import 'package:flutter/material.dart';

enum BookingStatus {
  active,
  upcoming,
  completed,
  canceled;

  @override
  String toString() => name;
}

enum VehicleType {
  car,
  bike;

  @override
  String toString() => name;
}

class Booking {
  final int? id;
  final String stationName;
  final String address;
  final DateTime startTime;
  final DateTime endTime;
  final BookingStatus status;
  final double totalCost;
  final double energyConsumed;
  final VehicleType vehicleType;
  final String? userId;

  Booking({
    this.id,
    required this.stationName,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.vehicleType,
    this.totalCost = 0.0,
    this.energyConsumed = 0.0,
    this.userId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      stationName: json['station_name'] as String,
      address: json['address'] as String,
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      status: BookingStatus.values.firstWhere((e) => e.toString() == json['status']),
      vehicleType: VehicleType.values.firstWhere((e) => e.toString() == json['vehicle_type']),
      totalCost: (json['total_cost'] as num).toDouble(),
      energyConsumed: (json['energy_consumed'] as num).toDouble(),
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'station_name': stationName,
      'address': address,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'status': status.toString(),
      'vehicle_type': vehicleType.toString(),
      'total_cost': totalCost,
      'energy_consumed': energyConsumed,
      'user_id': userId,
    };
  }
}