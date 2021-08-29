import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_application/models/wall_paper_model.dart';

class NetworkHandler {
  String baseUrl = "https://api.pexels.com";
  var logger = Logger();

  Future<List<WallpaperModel>> getWallpapers(String url) async {
    String apiKey = "563492ad6f91700001000001b48027c58e1548f7ac33743b2c0b6e68";
    url = formater(url);
    http.Response response =
        await http.get(Uri.parse(url), headers: {"Authorization": apiKey});
    //logger.i(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonMap = jsonDecode(response.body);
      //print(jsonMap);
      List<WallpaperModel> wallpapers = (jsonMap['photos'] as List)
          .map((item) => WallpaperModel.fromJson(item))
          .toList();
      //print(wallpapers.length);
      return wallpapers;
    } else {
      throw "No data found";
    }
  }

  String formater(String url) {
    return baseUrl + url;
  }
}
