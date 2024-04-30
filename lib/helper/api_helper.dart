import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/photo_model.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();
  String apiKey = '41980418-5d85892b3ed54d4d9ddc1cf71';


  Future<List<Photo>?> fetchphotos([String searchedText = '']) async {
    String uri =
        'https://pixabay.com/api/?key=$apiKey&q=$searchedText&orientation=vertical';
    http.Response response = await http.get(
      Uri.parse(uri),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      Map decodeData = jsonDecode(data);
      List photodata = decodeData['hits'];
      return photodata.map((e) {
        return Photo(photo: e['largeImageURL']);
      }).toList();
    }
    return null;
  }
}
