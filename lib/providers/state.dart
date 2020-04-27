import 'package:flutter/material.dart';
import './city.dart';

class StateData{
  final String id;
  final String name;
  final int confirmed;
  final int active;
  final int recovered;
  final int deceased;
  final List<City> cityList;
  StateData({
    @required this.id,
    @required this.name,
    @required this.confirmed,
    @required this.active,
    @required this.recovered,
    @required this.deceased,
    @required this.cityList,
  });
}
