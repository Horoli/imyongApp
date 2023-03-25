part of 'lib.dart';

class ServiceMGuestLogin {
  static ServiceMGuestLogin? _instance;
  factory ServiceMGuestLogin.getInstance() =>
      _instance ??= ServiceMGuestLogin._internal();

  TStream<String> $token = TStream<String>();

  String get token => $token.lastValue;

  ServiceMGuestLogin._internal();

  void hiveBoxlistener() {
    hiveMGuestLogin.watch().listen((event) {
      print('event $event');
    });
  }

  Future<RestfulResult> login(String guestID) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    print('guestID $guestID');

    // final Map<String, String> _headers = createHeaders(
    //   tokenKey: HEADER.TOKEN,
    //   tokenValue: hiveMGuestLogin.values.first.token,
    // );

    String encodeData = jsonEncode({"id": guestID});

    http
        .post(getRequestUri(PATH.GUEST_LOGIN),
            headers: createHeaders(), body: encodeData)
        .then((response) {
      if (response == null) {
        return completer.complete(RestfulResult(
          statusCode: STATUS.UNKNOWN_CODE,
          message: STATUS.UNKNOWN_MSG,
        ));
      }

      Map result = json.decode(response.body);
      if (response.statusCode == STATUS.SUCCESS_CODE) {
        MGuestLogin convertedItem = MGuestLogin.fromMap(result['data'] ?? {});

        // print('convertedGuest $convertedItem');
        // print('convertedGuest ${convertedItem.token}');
        $token.sink$(convertedItem.token);
        hiveMGuestLogin.put(guestID, convertedItem);
      } else {
        hiveMGuestLogin.put(guestID, MGuestLogin(token: ''));
      }

      print(hiveMGuestLogin.keys);
      print(hiveMGuestLogin.values.first.token);

      return completer.complete(RestfulResult.fromMap(
        result,
        response.statusCode,
      ));
    }).catchError((error) {
      print('Error: $error');
      // TODO : create error page(pop)
      return completer.complete(
        RestfulResult(
          statusCode: STATUS.CONNECTION_FAILED_CODE,
          message: STATUS.CONNECTION_FAILED_MSG,
        ),
      );
    }).timeout(
      const Duration(milliseconds: 5000),
      onTimeout: () => completer.complete(
        RestfulResult(
          statusCode: STATUS.CONNECTION_FAILED_CODE,
          message: STATUS.REQUEST_TIMEOUT,
        ),
      ),
    );

    return completer.future;
  }
}
