part of 'lib.dart';

class ServiceGuest {
  static ServiceGuest? _instance;
  factory ServiceGuest.getInstance() => _instance ??= ServiceGuest._internal();

  ServiceGuest._internal();

  TStream<MGuest> $guest = TStream<MGuest>();
  MGuest get guest => $guest.lastValue;

  // TODO : change http.post to completer
  Future<RestfulResult> post({required String uuid}) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();
    String encodeData = jsonEncode({"id": uuid});

    // assert(uuid == '', "uuid is empty(" ")");
    http
        .post(getRequestUri(PATH.GUEST),
            headers: createHeaders(), body: encodeData)
        .then((response) {
      Map<String, dynamic> item =
          Map.from(jsonDecode(response.body)['data'] ?? {});
      print('item $item');

      MGuest tmpGuest = MGuest.fromMap(item);
      $guest.sink$(tmpGuest);
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
    final Map<String, String> _headers = createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: hiveMGuestLogin.values.first.token,
    );

    String query = 'guest?id=${guestID}';

    http.get(getRequestUri(query), headers: _headers).then((response) {
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
}
