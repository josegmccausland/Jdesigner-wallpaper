import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jdesigner/constants/constants.dart';

abstract class WallpaperRepository {
  Future<List> fetchWallpaper();
}

class WallpaperImplements implements WallpaperRepository {
  @override
  Future<List> fetchWallpaper() async {
    final response = await http.get(apiUrl);
    var convertJson = jsonDecode(response.body);
    return convertJson;
  }
}
