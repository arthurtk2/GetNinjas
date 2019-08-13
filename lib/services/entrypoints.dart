import 'package:http/http.dart' as http;

class ApiEntryPoints {
  static Future get() async {
    final String mainUrl = 'http://testemobile.getninjas.com.br';

    return http.get(mainUrl);
  }
}
