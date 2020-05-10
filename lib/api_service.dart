//import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './model/artist.dart';
import './model/page_list.dart';
import './model/record.dart';
import './model/song.dart';

class ApiService {
  Uri uri;
  http.Client _client;

  ApiService({String host, int port}) {
    this.uri = Uri(host: host, port: port);
    this._client = http.Client();
  }

  static ApiService instance;

  Record parseRecord(String responseBody) {
    Map<String, dynamic> _json = json.decode(responseBody);
//    Map<String, dynamic> _json = jsonDecode(responseBody);
    return Record.fromJson(_json);
  }

  Song parseSong(String responseBody) {
    Map<String, dynamic> _json = json.decode(responseBody);
//    Map<String, dynamic> _json = jsonDecode(responseBody);
    return Song.fromJson(_json);
  }

  Artist parseArtist(String responseBody) {
    Map<String, dynamic> _json = json.decode(responseBody);
//    Map<String, dynamic> _json = jsonDecode(responseBody);
    return Artist.fromJson(_json);
  }

  Future<Record> fetchRecord(int id) async {
    Uri uri = Uri.http(this.uri.authority, '/api/records/${id}/');

    print('fetchRecord uri:$uri');

    final response = await _client.get(uri);
//    return parseRecord(response.body);
    return parseRecord(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<Song> fetchSong(int id) async {
    Uri uri = Uri.http(this.uri.authority, '/api/songs/${id}/');

    print('fetchSong url:$uri');

    final response = await _client.get(uri);
//    return parseRecord(response.body);
    return parseSong(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<Artist> fetchArtist(int id) async {
    Uri uri = Uri.http(this.uri.authority, '/api/artists/${id}/');

    print('fetchArtist uri:$uri');

    final response = await _client.get(uri);
//    return parseArtist(response.body);
    return parseArtist(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<PageList<Record>> getRecords(
      {String title,
      int format,
      String year,
      int companyId,
      int offset = 0,
      int limit = 20}) async {
    Map<String, String> queryParameters = {};
    if (title != null) {
      queryParameters['title'] = title;
    }
    if (format != null) {
      queryParameters['format'] = format.toString();
    }
    if (year != null) {
      queryParameters['year'] = year;
    }
    if (companyId != null) {
      queryParameters['company_id'] = companyId.toString();
    }
    queryParameters['offset'] = offset.toString();
    queryParameters['limit'] = limit.toString();

    print('getRecords() queryParameters = $queryParameters');

    Uri uri = Uri.http(this.uri.authority, '/api/records/', queryParameters);
    print('getRecords() uri = $uri');

    final response = await _client.get(uri);

//    print('getRecords response = $response');
//    print('getRecords response.body = ${response.body}');
//    print('getRecords json.decode(responseBody) = ${json.decode(response.body)}');

    Map<String, dynamic> decode =
        json.decode(Utf8Decoder().convert(response.bodyBytes));

    PageList<Record> pageList = PageList<Record>();
    pageList.count = decode['count'];
    pageList.results =
        decode['results'].map<Record>((json) => Record.fromJson(json)).toList();

    return pageList;
  }

  Future<PageList<Artist>> getArtists(
      {String name,
      int type,
      int offset = 0,
      bool recordIsNull,
      bool typeIsNull,
      int limit = 20}) async {
    Map<String, String> queryParameters = {};
    if (name != null) {
      queryParameters['name'] = name;
    }
    if (type != null) {
      queryParameters['type'] = type.toString();
    }
    if (recordIsNull != null) {
      queryParameters['record_isnull'] = recordIsNull.toString();
      queryParameters['record__isnull'] = recordIsNull.toString();
    }
    if (typeIsNull != null) {
      queryParameters['type__isnull'] = typeIsNull.toString();
    }

    queryParameters['offset'] = offset.toString();
    queryParameters['limit'] = limit.toString();

    print('getArtists() queryParameters = $queryParameters');

    Uri uri = Uri.http(this.uri.authority, '/api/artists/', queryParameters);
    print('getArtists() uri = $uri');

    final response = await _client.get(uri);

//    print('getRecords response = $response');
//    print('getRecords response.body = ${response.body}');
//    print('getRecords json.decode(responseBody) = ${json.decode(response.body)}');

    Map<String, dynamic> decode =
        json.decode(Utf8Decoder().convert(response.bodyBytes));

    PageList<Artist> pageList = PageList<Artist>();
    pageList.count = decode['count'];
    pageList.results =
        decode['results'].map<Artist>((json) => Artist.fromJson(json)).toList();

    return pageList;
  }

  Future<PageList<Song>> getSongs(
      {String title,
        int offset = 0,
        int limit = 20}) async {
    Map<String, String> queryParameters = {};
    if (title != null) {
      queryParameters['title'] = title;
    }

    queryParameters['offset'] = offset.toString();
    queryParameters['limit'] = limit.toString();

    print('getSongs() queryParameters = $queryParameters');

    Uri uri = Uri.http(this.uri.authority, '/api/songs/', queryParameters);
    print('getSongs() uri = $uri');

    final response = await _client.get(uri);

//    print('getRecords response = $response');
//    print('getRecords response.body = ${response.body}');
//    print('getRecords json.decode(responseBody) = ${json.decode(response.body)}');

    Map<String, dynamic> decode =
    json.decode(Utf8Decoder().convert(response.bodyBytes));

    PageList<Song> pageList = PageList<Song>();
    pageList.count = decode['count'];
    pageList.results =
        decode['results'].map<Song>((json) => Song.fromJson(json)).toList();

    return pageList;
  }

  Future<PageList<Record>> getArtistRecords(
      {int artistId,
        int offset = 0,
        int limit = 20}) async {
    Map<String, String> queryParameters = {};

    queryParameters['offset'] = offset.toString();
    queryParameters['limit'] = limit.toString();

    print('getArtistRecords() queryParameters = $queryParameters');

    Uri uri = Uri.http(this.uri.authority, '/api/artists/${artistId}/records/', queryParameters);
    print('getArtistRecords() uri = $uri');

    final response = await _client.get(uri);

//    print('getRecords response = $response');
//    print('getRecords response.body = ${response.body}');
//    print('getRecords json.decode(responseBody) = ${json.decode(response.body)}');

    Map<String, dynamic> decode =
    json.decode(Utf8Decoder().convert(response.bodyBytes));

    PageList<Record> pageList = PageList<Record>();
    pageList.count = decode['count'];
    pageList.results =
        decode['results'].map<Record>((json) => Record.fromJson(json)).toList();

    return pageList;
  }

  Future<PageList<Record>> getArtistComps(
      {int artistId,
        int offset = 0,
        int limit = 20}) async {
    Map<String, String> queryParameters = {};

    queryParameters['offset'] = offset.toString();
    queryParameters['limit'] = limit.toString();

    print('getArtistComps() queryParameters = $queryParameters');

    Uri uri = Uri.http(this.uri.authority, '/api/artists/${artistId}/comps/', queryParameters);
    print('getArtistComps() uri = $uri');

    final response = await _client.get(uri);

//    print('getRecords response = $response');
//    print('getRecords response.body = ${response.body}');
//    print('getRecords json.decode(responseBody) = ${json.decode(response.body)}');

    Map<String, dynamic> decode =
    json.decode(Utf8Decoder().convert(response.bodyBytes));

    PageList<Record> pageList = PageList<Record>();
    pageList.count = decode['count'];
    pageList.results =
        decode['results'].map<Record>((json) => Record.fromJson(json)).toList();

    return pageList;
  }

  Future<PageList<Song>> getArtistSongs(
      {int artistId,
        int offset = 0,
        int limit = 20}) async {
    Map<String, String> queryParameters = {};

    queryParameters['offset'] = offset.toString();
    queryParameters['limit'] = limit.toString();

    print('getArtistSongs() queryParameters = $queryParameters');

    Uri uri = Uri.http(this.uri.authority, '/api/artists/${artistId}/songs/', queryParameters);
    print('getArtistSongs() uri = $uri');

    final response = await _client.get(uri);

//    print('getRecords response = $response');
//    print('getRecords response.body = ${response.body}');
//    print('getRecords json.decode(responseBody) = ${json.decode(response.body)}');

    Map<String, dynamic> decode =
    json.decode(Utf8Decoder().convert(response.bodyBytes));

    PageList<Song> pageList = PageList<Song>();
    pageList.count = decode['count'];
    pageList.results =
        decode['results'].map<Song>((json) => Song.fromJson(json)).toList();

    return pageList;
  }
}
