import 'dart:convert';

import 'package:earthquak/models/earthquake_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EarthquakeProvider with ChangeNotifier {
  final String baseUrl = 'https://earthquake.usgs.gov/fdsnws/event/1/';
  final String endUrl = 'query?format=geojson&starttime=2023-10-13&endtime=2023-10-14&minmagnitude=5';
  EarthquakeModel? earthquakeData;

  bool get hasDataLoaded => earthquakeData != null;

  Future<void>  getData () async {
    await _getEarthquakeData();
  }

  Future<void> _getEarthquakeData () async {
    final url = Uri.parse('$baseUrl$endUrl');
    try {
      final response = await http.get(url);
      final json = jsonDecode(response.body) as Map<String, dynamic> ;
      if (response.statusCode == 200 ) {
        earthquakeData = EarthquakeModel.fromJson(json);
        print(earthquakeData!.features!.length);
        notifyListeners();
      }else {
        print(json['message']);
      }
    }catch (error) {

    }
  }
}