import 'package:muy_test/http/url.dart';
import 'package:http/http.dart' as http;

class Request {
  
  final String url;
  final dynamic body;

  Request({this.url, this.body});

  ///Metodo get http
  Future<http.Response> get() {
    return http.get(urlBase + url).timeout(Duration(minutes: 2));
  }
}