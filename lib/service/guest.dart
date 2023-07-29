part of 'lib.dart';

class ServiceGuest {
  static ServiceGuest? _instance;
  factory ServiceGuest.getInstance() => _instance ??= ServiceGuest._internal();

  ServiceGuest._internal();

  TStream<MGuest> $guest = TStream<MGuest>();
  MGuest get guest => $guest.lastValue;

  Future<RestfulResult> post({required String guestID}) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();
    String encodeData = jsonEncode({"id": guestID});

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.GUEST)
        : Uri.https(PATH.FORIEGN_URL, PATH.GUEST);
    http
        .post(query, headers: GUtility.createHeaders(), body: encodeData)
        .then((response) {
      Map<String, dynamic> result =
          Map.from(jsonDecode(response.body)['data'] ?? {});

      MGuest tmpGuest = MGuest.fromMap(result);
      GUtility.log('tmpGuest ${tmpGuest}');
      GUtility.log('tmpGuest.wishQuestion ${tmpGuest.wishQuestion}');

      $guest.sink$(tmpGuest);
      return completer.complete(RestfulResult.fromMap(
        jsonDecode(response.body),
        response.statusCode,
      ));
    }).catchError((error) {
      // TODO : create error page(pop)
      GUtility.log('error $error');
      return completer.complete(
        RestfulResult(
          statusCode: STATUS.CONNECTION_FAILED_CODE,
          message: STATUS.CONNECTION_FAILED_MSG,
        ),
      );
    });
    return completer.future;
  }

  Future<RestfulResult> get(String guestID) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    GUtility.log('guestID $guestID');
    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString('token'),
    );

    Map<String, String> queryParameters = {"id": guestID};

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.GUEST, queryParameters)
        : Uri.https(PATH.FORIEGN_URL, PATH.GUEST, queryParameters);

    http.get(query, headers: _headers).then((response) {
      GUtility.log('get ${response.body}');
    });

    return completer.future;
  }

  Future<RestfulResult> patch(MGuest guest) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    String encodeData = jsonEncode({
      "id": guest.id,
      "wishQuestion": guest.wishQuestion,
    });

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.GUEST)
        : Uri.https(PATH.FORIEGN_URL, PATH.GUEST);

    http.patch(query, headers: _headers, body: encodeData).then((response) {
      Map<String, dynamic> result =
          Map.from(jsonDecode(response.body)['data'] ?? {});

      MGuest tmpGuest = MGuest.fromMap(result);
      GUtility.log('tmpGuest ${tmpGuest}');
      GUtility.log('tmpGuest.wishQuestion ${tmpGuest.wishQuestion}');

      $guest.sink$(tmpGuest);
      return completer.complete(RestfulResult.fromMap(
        jsonDecode(response.body),
        response.statusCode,
      ));
    });

    // if (response.statusCode != STATUS.SUCCESS_CODE) {
    //   throw Exception(STATUS.LOAD_FAILED_MSG);
    // }

    // Map<String, dynamic> item =
    //     Map.from(jsonDecode(response.body)['data']['guest'] ?? {});

    // Map<String, MGuest> convertedItem = item.map<String, MGuest>(
    //     (key, value) => MapEntry(key, MGuest.fromMap(value)));

    // $guest.sink$(convertedItem);
    return completer.future;
  }
}
