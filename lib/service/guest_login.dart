part of 'lib.dart';

class ServiceMGuestLogin {
  static ServiceMGuestLogin? _instance;
  factory ServiceMGuestLogin.getInstance() =>
      _instance ??= ServiceMGuestLogin._internal();

  TStream<String> $token = TStream<String>();

  String get token => $token.lastValue;

  ServiceMGuestLogin._internal();

  Future<RestfulResult> login(String guestId) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    GUtility.log('guestIddddd $guestId');

    String encodeData = jsonEncode({"id": guestId});

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.GUEST_LOGIN)
        : Uri.https(PATH.FORIEGN_URL, PATH.GUEST_LOGIN);

    http
        .post(query, headers: GUtility.createHeaders(), body: encodeData)
        .then((response) {
      if (response == null) {
        return completer.complete(RestfulResult(
          statusCode: STATUS.UNKNOWN_CODE,
          message: STATUS.UNKNOWN_MSG,
        ));
      }

      Map result = json.decode(response.body);

      if (response.statusCode != STATUS.SUCCESS_CODE) {
        GSharedPreferences.setString('token', '');
      }

      if (response.statusCode == STATUS.SUCCESS_CODE) {
        GUtility.log('result $result');
        MGuestLogin convertedItem = MGuestLogin.fromMap(result['data'] ?? {});
        $token.sink$(convertedItem.token);

        // TODO : 헷갈릴 수 있는데, 여기서 guestId가 아니라 받아온 토큰을 set해야함
        GSharedPreferences.setString('token', convertedItem.token);
      }

      return completer.complete(RestfulResult.fromMap(
        result,
        response.statusCode,
      ));
    }).catchError((error) {
      GUtility.log('Error: $error');
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
