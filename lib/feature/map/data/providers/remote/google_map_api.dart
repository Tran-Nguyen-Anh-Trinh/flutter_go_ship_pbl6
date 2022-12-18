import 'package:flutter_go_ship_pbl6/feature/map/data/models/map_position.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GoogleMapAPI {
  // Future<List<MapPosition>> searchMapPlace(String input) async {
  //   final String url =
  //       'https://maps.googleapis.com/maps/api/place/textsearch/json?key=${AppConfig.googleApiKeySearch}&query=$input';
  //   print(url);
  //   var response = await http.get(Uri.parse(url));

  //   var json = convert.jsonDecode(response.body);

  //   var results = json['results'] as List<dynamic>;
  //   List<MapPosition> positions = [];
  //   for (var place in results) {
  //     final double lat = place['geometry']['location']['lat'];
  //     final double lng = place['geometry']['location']['lng'];
  //     final String name = place['name'] as String;
  //     positions.add(
  //       MapPosition(name, LatLng(lat, lng)),
  //     );
  //   }
  //   return positions;
  // }

  Future<List<MapPosition>> searchMapPlace(String input) async {
    final String url =
        'https://api.openrouteservice.org/geocode/search?api_key=${AppConfig.openrouteApiKeyDirections}&text=${input}';

    print(url);
    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    List<MapPosition> pointLatLng = [];

    try {
      var results = json['features'] as List<dynamic>;
      for (var result in results) {
        var positions = result['geometry']['coordinates'] as List<dynamic>;
        var name = result['properties']['name'] as String;
        LatLng latLng = LatLng(positions[1] as double, positions[0] as double);
        pointLatLng.add(MapPosition(name, latLng));
      }

      return pointLatLng;
    } catch (e) {
      return [];
    }
  }

  Future<List<LatLng>> direct(LatLng start, LatLng end, String traffic) async {
    final String url =
        'https://api.openrouteservice.org/v2/directions/$traffic?api_key=${AppConfig.openrouteApiKeyDirections}&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}';

    print(url);
    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    try {
      var results = json['features'][0]['geometry']['coordinates'] as List<dynamic>;
      List<LatLng> pointLatLng = [];
      for (var positions in results) {
        LatLng latLng = LatLng(positions[1] as double, positions[0] as double);

        pointLatLng.add(latLng);
      }
      return pointLatLng;
    } catch (e) {
      return [];
    }
  }
}
