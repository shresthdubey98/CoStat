import 'dart:convert';
import 'package:intl/intl.dart';

import '../models/http_exception.dart';
import '../models/time_series_case.dart';
import '../providers/city.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Statistics extends ChangeNotifier {
  List<StateData> _states = [];
  List<StateData> _watchlist = [];
  List<TimeSeriesCase> _timeSeriesCases = [];
  DateTime _lastUpdateTime = DateTime.now();

  DateTime get lastUpdateTime => _lastUpdateTime;

  Future<void> fetchAndSetWatchlistStateIds() async {
    await fetchAndSetStates();
    _watchlist = [];
    print('fetch and set states called');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      return;
    }
    final uId = user.uid;
    String token = (await user.getIdToken()).token;
    final url =
        "https://covid19india-18e25.firebaseio.com/watchlist/$uId.json?auth=$token";
    final response = await http.get(url);
//    print(response.body);
    if (response.body == "null") {
      return;
    }
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    final watchIds = [];
    jsonResponse.forEach((key, value) {
      _watchlist.add(_states.firstWhere((state) => state.id == key));
    });
    notifyListeners();
  }

  Future<void> fetchAndSetStates() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String token = (await user.getIdToken()).token;
    print('fetch and set states called');
    final stateDataUrl = "https://api.covid19india.org/data.json";
    final districtDataUrl =
        "https://api.covid19india.org/v2/state_district_wise.json";
    try {
      final stateResponse = await http.get(stateDataUrl);
      final districtResponse = await http.get(districtDataUrl);
      final stateExtractedData =
          jsonDecode(stateResponse.body) as Map<String, dynamic>;
      final districtWiseData = jsonDecode(districtResponse.body) as List;
      final stateWiseData = stateExtractedData['statewise'] as List;
      final keyValuesList = stateExtractedData['key_values'] as List;
      final keyValuesJson = keyValuesList[0];
      _lastUpdateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(keyValuesJson['lastupdatedtime'].toString());
      print(_lastUpdateTime);
      stateWiseData.removeWhere((element) =>
          element['state'] == 'Total' || element['confirmed'] == '0');
      _states = stateWiseData.map((stateData) {
        final stateName = stateData['state'];
        final confirmed = int.parse(stateData['confirmed']);
        final active = int.parse(stateData['active']);
        final recovered = int.parse(stateData['recovered']);
        final deceased = int.parse(stateData['deaths']);
//        print(districtWiseData[0]);
        final underlyingDistrictsJson = districtWiseData.firstWhere(
            (element) => element['state'] == stateName) as Map<String, dynamic>;
        final underlyingDistrictsJsonList =
            underlyingDistrictsJson['districtData'] as List;
        final cityObjList = underlyingDistrictsJsonList.map((city) => City(
              name: city['district'].toString(),
              confirmed: city['confirmed'],
            )).toList();
        return StateData(
          id:stateName,
          name:stateName,
          confirmed: confirmed,
          active: active,
          recovered: recovered,
          deceased: deceased,
          cityList: cityObjList
        );
      }).toList();
      notifyListeners();
//      final List<StateData> loadedStates = [];
//      if (extractedData == null) {
//        return;
//      }
//      extractedData.forEach((stateId, stateData) {
//        final extractedCities = stateData['districts'] as List<dynamic>;
//        final List<City> loadedCities = [];
//        extractedCities.forEach((innerMap) {
//          loadedCities.add(City(
//              name: innerMap['district'],
//              confirmed: int.parse(innerMap['confirmed'])));
//        });
//        loadedStates.add(StateData(
//            id: stateId,
//            name: stateData['state'],
//            confirmed: stateData['active'] != '-'
//                ? int.parse(stateData['confirmed'])
//                : -1,
//            active: stateData['active'] != '-'
//                ? int.parse(stateData['active'])
//                : -1,
//            deceased: stateData['deaths'] != '-'
//                ? int.parse(stateData['deaths'])
//                : -1,
//            recovered: stateData['recovered'] != '-'
//                ? int.parse(stateData['recovered'])
//                : -1,
//            cityList: loadedCities));
//      });
//      _states = loadedStates;
//      fetchAndSetOldData();
    } on Exception catch (e) {
      throw HttpException("Network Error");
    }
  }

  List<StateData> get watchlist {
    return [..._watchlist];
  }

  Future<void> addToWatchlist(String stateId, String uId) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String token = (await user.getIdToken()).token;
    final url =
        "https://covid19india-18e25.firebaseio.com/watchlist/$uId/$stateId.json?auth=$token";
    try {
      final response = await http.put(url, body: jsonEncode(true));
      if (response.statusCode >= 400) {
        throw (HttpException("Connection Error"));
      }
      notifyListeners();
    } catch (error) {
      throw (HttpException("Connection Error"));
    }
  }

  Future<void> deleteFromWatchlist(String stateId) async {
    final oldState = watchlist.firstWhere((state) => state.id == stateId);
    _watchlist.removeWhere((state) => state.id == stateId);
    notifyListeners();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uId = user.uid;
    String token = (await user.getIdToken()).token;
    final url =
        "https://covid19india-18e25.firebaseio.com/watchlist/$uId/$stateId.json?auth=$token";
    print(url);
    try {
      final response =
          await http.delete(url).catchError((error) => print(error));
      print((response.body));
      if (response.statusCode >= 400) {
        _watchlist.add(oldState);
        notifyListeners();
        print('error');
        //throw (HttpException("Connection Error"));
      }
      notifyListeners();
    } catch (error) {
      _watchlist.add(oldState);
      notifyListeners();
      print('error2');
      //throw (HttpException("Connection Error"));
    }
  }

//  Future<void> fetchAndSetStates() async {
//    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    String token = (await user.getIdToken()).token;
//    print('fetch and set states called');
//    final url = "https://covid19india-18e25.firebaseio.com/covid19data.json?auth=$token";
//    try {
//      final response = await http.get(url);
//      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
//      final List<StateData> loadedStates = [];
//      if (extractedData == null) {
//        return;
//      }
//      extractedData.forEach((stateId, stateData) {
//        final extractedCities = stateData['districts'] as List<dynamic>;
//        final List<City> loadedCities = [];
//        extractedCities.forEach((innerMap) {
//          loadedCities.add(City(
//              name: innerMap['district'],
//              confirmed: int.parse(innerMap['confirmed'])));
//        });
//        loadedStates.add(StateData(
//            id: stateId,
//            name: stateData['state'],
//            confirmed: stateData['active'] != '-'
//                ? int.parse(stateData['confirmed'])
//                : -1,
//            active: stateData['active'] != '-'
//                ? int.parse(stateData['active'])
//                : -1,
//            deceased: stateData['deaths'] != '-'
//                ? int.parse(stateData['deaths'])
//                : -1,
//            recovered: stateData['recovered'] != '-'
//                ? int.parse(stateData['recovered'])
//                : -1,
//            cityList: loadedCities));
//      });
//      _states = loadedStates;
//      notifyListeners();
//    //  fetchAndSetOldData();
//    } on Exception catch (e) {
//      throw HttpException("Network Error");
//    }
//  }

  List<StateData> get getStates {
    return [..._states];
  }

  StateData findStateById(String id) {
    return _states.firstWhere((state) => state.id == id);
  }

  double percentById(String id) {
    if (_states.length == 0) {
      return -1;
    }
    var total = 0;
    _states.forEach((state) {
      total += state.confirmed;
    });
    final currentState = _states.firstWhere((state) => state.id == id);
    var percent = currentState.confirmed / total * 100;
    return percent;
  }

  Future<void> fetchAndSetOldData() async {
    print('fetchAndSetOldData called');
    final backupTimeSeries = _timeSeriesCases;
    _timeSeriesCases = [];
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String token = (await user.getIdToken()).token;
    final url = "https://api.covid19india.org/data.json?auth=$token";
    try {
      final response = await http.get(url);
      final extractedData =
          jsonDecode(response.body)['cases_time_series'] as List;
      extractedData.forEach((timeSeriesCase) {
        final jsonTemp = timeSeriesCase;
        var month;
        if (jsonTemp['date'].toString().toLowerCase().contains('january')) {
          month = '01';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('february')) {
          month = '02';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('march')) {
          month = '03';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('april')) {
          month = '04';
        } else if (jsonTemp['date'].toString().toLowerCase().contains('may')) {
          month = '05';
        } else if (jsonTemp['date'].toString().toLowerCase().contains('june')) {
          month = '06';
        } else if (jsonTemp['date'].toString().toLowerCase().contains('july')) {
          month = '07';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('august')) {
          month = '08';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('september')) {
          month = '09';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('october')) {
          month = '10';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('november')) {
          month = '11';
        } else if (jsonTemp['date']
            .toString()
            .toLowerCase()
            .contains('december')) {
          month = '12';
        } else {
          print('month not found');
          return;
        }
        var date =
            jsonTemp['date'].toString()[0] + jsonTemp['date'].toString()[1];
        final finalDate = '2020-$month-$date 00:00:00.000';
        final parsedDate = DateTime.parse(finalDate);
        _timeSeriesCases.add(TimeSeriesCase(
          date: parsedDate,
          dailyConfirmed: int.parse(jsonTemp['dailyconfirmed']),
          totalDeceased: int.parse(jsonTemp['dailydeceased']),
          dailyRecovered: int.parse(jsonTemp['dailyrecovered']),
          totalConfirmed: int.parse(jsonTemp['totalconfirmed']),
          dailyDeceased: int.parse(jsonTemp['totaldeceased']),
          totalRecovered: int.parse(jsonTemp['totalrecovered']),
        ));
      });
      print("notifieng listners");
      notifyListeners();
    } on Exception catch (e) {
      _timeSeriesCases = backupTimeSeries;
      notifyListeners();
      throw HttpException("Network Error");
    }
  }

  int get totalConfirmed {
    var temp = 0;
    _states.forEach((e) {
      temp += e.confirmed > 0 ? e.confirmed : 0;
    });
    return temp;
  }

  int get totalActive {
    var temp = 0;
    _states.forEach((e) {
      temp += e.active > 0 ? e.active : 0;
    });
    return temp;
  }

  int get totalRecovered {
    var temp = 0;
    _states.forEach((e) {
      temp += e.recovered > 0 ? e.recovered : 0;
    });
    return temp;
  }

  int get totalDead {
    var temp = 0;
    _states.forEach((e) {
      temp += e.deceased > 0 ? e.deceased : 0;
    });
    return temp;
  }
}
