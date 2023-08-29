part of 'lib.dart';

class ServiceGuest {
  static ServiceGuest? _instance;
  factory ServiceGuest.getInstance() => _instance ??= ServiceGuest._internal();

  ServiceGuest._internal();

  TStream<MGuest> $guest = TStream<MGuest>();
  MGuest get guest => $guest.lastValue;

  Future<RestfulResult> post({required String guestId}) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();
    String encodeData = jsonEncode({"id": guestId});

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

  Future<RestfulResult> get(String guestId) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    GUtility.log('guestId $guestId');
    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString('token'),
    );

    Map<String, String> queryParameters = {"id": guestId};

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
      print('result $result');

      if (result.isEmpty) {
        return completer.complete(RestfulResult.fromMap(
          jsonDecode(response.body),
          response.statusCode,
        ));
      }

      MGuest tmpGuest = MGuest.fromMap(result);
      GUtility.log('tmpGuest ${tmpGuest.id}');
      GUtility.log('tmpGuest.wishQuestion ${tmpGuest.wishQuestion}');

      $guest.sink$(tmpGuest);
      return completer.complete(RestfulResult.fromMap(
        jsonDecode(response.body),
        response.statusCode,
      ));
    }).catchError((e) {
      GUtility.log('error $e');
      return completer.complete(
        RestfulResult(
          statusCode: STATUS.CONNECTION_FAILED_CODE,
          message: STATUS.CONNECTION_FAILED_MSG,
        ),
      );
    });

    return completer.future;
  }

  // TODO : 해당 question을 삭제하는 함수(단일)
  void patchWishQuestion(MGuest guest, String questionId) {
    MGuest tmpGuest = guest.copyWith();
    print('patchWishQuestion tmpGuest.id step1 ${tmpGuest.id}');
    List<String> wishQuestions = tmpGuest.wishQuestion;

    bool hasCheck = wishQuestions.contains(questionId);

    hasCheck ? wishQuestions.remove(questionId) : wishQuestions.add(questionId);

    GUtility.log('wish $wishQuestions');
    tmpGuest = tmpGuest.copyWith(wishQuestion: wishQuestions);
    print('patchWishQuestion tmpGuest.id step2 ${tmpGuest.id}');
    patch(tmpGuest);
  }

  // TODO : 선택한 questions을 삭제하는 함수(복수)
  void removeWishQuestions(
    MGuest guest,
    List<String> questionIds,
  ) {
    MGuest tmpGuest = guest.copyWith();
    List<String> tmpWishQuestions = List.from(tmpGuest.wishQuestion);
    print('wish $tmpWishQuestions');
    print('questionIds $questionIds');

    questionIds.forEach((id) {
      if (!tmpWishQuestions.contains(id)) {
        GUtility.log('is not exist, Ids $id');
      }
      print('id $id');
      tmpWishQuestions.remove(id);
    });

    tmpGuest = tmpGuest.copyWith(wishQuestion: tmpWishQuestions);
    patch(tmpGuest);
    print('questionIds $tmpWishQuestions');
  }

  void clearWishQuestions(MGuest guest) {
    MGuest tmpGuest = guest.copyWith();
    List<String> tmpWishQuestions = List.from(tmpGuest.wishQuestion);

    tmpWishQuestions.clear();
    tmpGuest = tmpGuest.copyWith(wishQuestion: tmpWishQuestions);
    patch(tmpGuest);
  }
}
