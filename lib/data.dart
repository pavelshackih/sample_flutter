import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ImageDataSource {
  static final _key =
      "563492ad6f917000010000018c601edf80324277884b8638176b1d68";
  static final _httpClient = HttpClient();
  static final _request =
      "https://api.pexels.com/v1/search?query=cute+animals&per_page=60&page=1";

  Future<List<String>> getPhoto() async {
    final url = Uri.parse(_request);
    var request = await _httpClient.getUrl(url);
    request.headers.add("Authorization", _key);
    var map = await request
        .close()
        .then((response) => response.transform(utf8.decoder).join())
        .then((source) => jsonDecode(source) as Map);
    var list = map["photos"] as List;
    var result = List<String>();
    for (var item in list) {
      var tmp = item as Map;
      var src = tmp["src"] as Map;
      result.add(src["large"] as String);
    }
    return Future(() => result);
  }
}
