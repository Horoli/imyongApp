part of 'lib.dart';

class ServiceGuest {
  static ServiceGuest? _instance;
  factory ServiceGuest.getInstance() => _instance ??= ServiceGuest._internal();

  ServiceGuest._internal();

  TStream<MGuest> $guest = TStream<MGuest>();
  MGuest get guest => $guest.lastValue;

  Future<RestfulResult> post({required String uuid}) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();
    String encodeData = jsonEncode({"id": uuid});

    http
        .post(GUtility.getRequestUri(PATH.GUEST),
            headers: GUtility.createHeaders(), body: encodeData)
        .then((response) {
      Map<String, dynamic> result =
          Map.from(jsonDecode(response.body)['data'] ?? {});

      MGuest tmpGuest = MGuest.fromMap(result);
      print('tmpGuest ${tmpGuest}');
      print('tmpGuest.wishQuestion ${tmpGuest.wishQuestion}');

      $guest.sink$(tmpGuest);
      return completer.complete(RestfulResult.fromMap(
        jsonDecode(response.body),
        response.statusCode,
      ));
    }).catchError((error) {
      // TODO : create error page(pop)
      print('error $error');
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

    print('guestID $guestID');
    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: localStorage.getItem('token'),
      // tokenValue: hiveMGuestLogin.values.first.token,
    );

    String query = 'guest?id=${guestID}';

    http.get(GUtility.getRequestUri(query), headers: _headers).then((response) {
      print('get ${response.body}');
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

  Future<RestfulResult> patch(MGuest guest) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,

      tokenValue: localStorage.getItem('token'),
      // tokenValue: hiveMGuestLogin.values.first.token,
    );

    String encodeData = jsonEncode({
      "id": guest.id,
      "wishQuestion": guest.wishQuestion,
    });

    http
        .patch(GUtility.getRequestUri(PATH.GUEST),
            headers: _headers, body: encodeData)
        .then((response) {
      Map<String, dynamic> result =
          Map.from(jsonDecode(response.body)['data'] ?? {});

      MGuest tmpGuest = MGuest.fromMap(result);
      print('tmpGuest ${tmpGuest}');
      print('tmpGuest.wishQuestion ${tmpGuest.wishQuestion}');

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
