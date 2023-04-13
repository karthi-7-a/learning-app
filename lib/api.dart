import 'package:http/http.dart' as http;

Future getData(url) async {
  http.Response res = await http.get(Uri.parse(url));
  return res.body;
}
