//import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './model/artist.dart';
import './model/page_list.dart';
import './model/record.dart';
import './model/song.dart';

class ApiService {
  String authority = 'liujin.jios.org:8000';

//  String host;
  String baseUrl;

  http.Client _client;

  ApiService(String baseUrl) {
    this.baseUrl = baseUrl;
    this._client = http.Client();
  }

  static ApiService instance;

  // A function that converts a response body into a List<Photo>.
  List<Record> parseRecords(String responseBody) {
    print('parseRecords responseBody=$responseBody');

//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//    print('parseArtists parsed=$parsed json=$json');

//    return parsed.map<Artist>((json) => Artist.fromJson(json)).toList();

//      Map<String, dynamic> decode = jsonDecode(responseBody);
    Map<String, dynamic> decode = json.decode(responseBody);

//    Map<String, dynamic> decode = json.decode();

    return decode['results']
        .map<Record>((json) => Record.fromJson(json))
        .toList();
  }

  Future<List<Record>> fetchRecords() async {
    String url = baseUrl + 'records/';

    print('fetchRecords url:$url');

//    final response = await client.get('http://localhost:8888/api/artists/');
    final response = await _client.get(url);

    print('fetchArtists response:$response');
    print('fetchArtists response.body:$response.body');
    print('fetchArtists json.decode(responseBody):$json.decode(responseBody)');

    // Use the compute function to run parseArtists in a separate isolate.
//    return parseRecords(response.body);
    return parseRecords(Utf8Decoder().convert(response.bodyBytes));
//      return compute(parseRecords, response.body);
  }

  // A function that converts a response body into a List<Photo>.
  List<Artist> parseArtists(String responseBody) {
    print('parseArtists responseBody=$responseBody');

//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//    print('parseArtists parsed=$parsed json=$json');

//    return parsed.map<Artist>((json) => Artist.fromJson(json)).toList();

    Map<String, dynamic> decode = jsonDecode(responseBody);

    return decode['results']
        .map<Artist>((json) => Artist.fromJson(json))
        .toList();
  }

  Future<List<Artist>> fetchArtists() async {
    String url = baseUrl + 'artists/';

    print('fetchArtists url:$url');

//    final response = await client.get('http://localhost:8888/api/artists/');
    final response = await _client.get(url);

    print('fetchArtists response:$response');
    print('fetchArtists response.body:$response.body');
    print('fetchArtists json.decode(responseBody):$json.decode(responseBody)');

    // Use the compute function to run parseArtists in a separate isolate.
//    return parseArtists(response.body);
    return parseArtists(Utf8Decoder().convert(response.bodyBytes));
//    return compute(parseArtists, response.body);
  }

  List<Song> parseSongs(String responseBody) {
    print('parseRecords responseBody=$responseBody');

//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//    print('parseArtists parsed=$parsed json=$json');

//    return parsed.map<Artist>((json) => Artist.fromJson(json)).toList();

//      Map<String, dynamic> decode = jsonDecode(responseBody);
    Map<String, dynamic> decode = json.decode(responseBody);

    return decode['results'].map<Song>((json) => Song.fromJson(json)).toList();
  }

  Future<List<Song>> fetchSongs() async {
    String url = baseUrl + 'songs/';

    print('fetchSongs url:$url');

//    final response = await client.get('http://localhost:8888/api/artists/');
    final response = await _client.get(url);

    print('fetchSongs response:$response');
    print('fetchSongs response.body:$response.body');
    print('fetchSongs json.decode(responseBody):$json.decode(responseBody)');

    // Use the compute function to run parseArtists in a separate isolate.
//    return parseSongs(response.body);
    return parseSongs(Utf8Decoder().convert(response.bodyBytes));
//      return compute(parseRecords, response.body);
  }

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
    String url = baseUrl + 'records/$id';

    print('fetchRecord url:$url');

    final response = await _client.get(url);
//    return parseRecord(response.body);
    return parseRecord(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<Song> fetchSong(int id) async {
    String url = baseUrl + 'songs/$id';

    print('fetchSong url:$url');

    final response = await _client.get(url);
//    return parseRecord(response.body);
    return parseSong(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<Artist> fetchArtist(int id) async {
    String url = baseUrl + 'artists/$id';

    print('fetchArtist url:$url');

    final response = await _client.get(url);
//    return parseArtist(response.body);
    return parseArtist(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<List<Record>> fetchArtistRecords(int id) async {
    String url = baseUrl + 'artists/$id/records';

    print('fetchArtistRecord url=$url');

    final response = await _client.get(url);

    print('fetchArtistRecord response.body=$response.body');

//    return parseRecords(response.body);
    return parseRecords(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<List<Record>> fetchArtistComps(int id) async {
    String url = baseUrl + 'artists/$id/comps';

    print('fetchArtistComps url=:$url');

    final response = await _client.get(url);

    print('fetchArtistComps response.body=$response.body');

//    return parseRecords(response.body);
    return parseRecords(Utf8Decoder().convert(response.bodyBytes));
  }

  Future<List<Song>> fetchArtistSongs(int id) async {
    String url = baseUrl + 'artists/$id/songs';

    print('fetchArtistSongs url=:$url');

    final response = await _client.get(url);

    print('fetchArtistSongs response.body=$response.body');

//    return parseSongs(response.body);
    return parseSongs(Utf8Decoder().convert(response.bodyBytes));
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

    Uri uri = Uri.http(authority, '/api/records/', queryParameters);
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
    }

    queryParameters['offset'] = offset.toString();
    queryParameters['limit'] = limit.toString();

    print('getArtists() queryParameters = $queryParameters');

    Uri uri = Uri.http(authority, '/api/artists/', queryParameters);
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

    Uri uri = Uri.http(authority, '/api/songs/', queryParameters);
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

    Uri uri = Uri.http(authority, '/api/artists/${artistId}/records/', queryParameters);
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

    Uri uri = Uri.http(authority, '/api/artists/${artistId}/comps/', queryParameters);
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

    Uri uri = Uri.http(authority, '/api/artists/${artistId}/songs/', queryParameters);
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
