import 'dart:async';
import 'dart:convert';
import 'dart:io';

class PexelsApi {
  static final _authKeyHeader = "Authorization";
  static final _key =
      "563492ad6f917000010000018c601edf80324277884b8638176b1d68";

  static final _scheme = "https";
  static final _host = "api.pexels.com";
  static final _basePath = "v1/search";
  static final _perPageParam = "per_page";
  static final _pageParam = "page";
  static final _queryParam = "query";

  static final _perPageParamValue = "60";
  static final _pageParamValue = "1";

  static final _httpClient = HttpClient();

  Future<List<String>> getPhotos(String search) async {
    var request = await getSearchRequest(search);
    final map = await request
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

  Future<HttpClientRequest> getSearchRequest(String search) async {
    final url =
        Uri(scheme: _scheme, host: _host, path: _basePath, queryParameters: {
      _perPageParam: _perPageParamValue,
      _pageParam: _pageParamValue,
      _queryParam: Uri.decodeComponent(search),
    });
    final request = await _httpClient.getUrl(url);
    request.headers.add(_authKeyHeader, _key);
    return request;
  }
}
