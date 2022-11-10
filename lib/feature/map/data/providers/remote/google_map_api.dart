import 'package:flutter_go_ship_pbl6/feature/map/data/models/map_position.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GoogleMapAPI {
  Future<List<MapPosition>> searchMapPlace(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?key=${AppConfig.googleApiKeySearch}&query=$input';
    print(url);
    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['results'] as List<dynamic>;
    List<MapPosition> positions = [];
    for (var place in results) {
      final double lat = place['geometry']['location']['lat'];
      final double lng = place['geometry']['location']['lng'];
      final String name = place['name'] as String;
      positions.add(
        MapPosition(name, LatLng(lat, lng)),
      );
    }
    return positions;
  }
}
