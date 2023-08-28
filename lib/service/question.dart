part of 'lib.dart';

class ServiceQuestion {
  static ServiceQuestion? _instance;
  factory ServiceQuestion.getInstance() =>
      _instance ??= ServiceQuestion._internal();
  ServiceQuestion._internal();

  final TStream<int> $selectedIndex = TStream<int>();
  int get selectedIndex => $selectedIndex.lastValue;

  final TStream<List<MQuestion>> $questionList = TStream<List<MQuestion>>()
    ..sink$([]);
  List<MQuestion> get questions => $questionList.lastValue;

  final TStream<Map<String, MQuestion>> $mapOfQuestion =
      TStream<Map<String, MQuestion>>()..sink$({});
  Map<String, MQuestion> get mapOfQuestion => $mapOfQuestion.lastValue;

  final TStream<Map<String, List<MQuestion>>> $mapOfWishQuestion =
      TStream<Map<String, List<MQuestion>>>()..sink$({});

  final TStream<Map<String, int>> $mapOfTotalQuestionsCount =
      TStream<Map<String, int>>()..sink$({});

  Future<RestfulResult> getTotalQuestionsCount() {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );
    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.QUESTION_COUNTER)
        : Uri.https(PATH.FORIEGN_URL, PATH.QUESTION_COUNTER);

    http.get(query, headers: headers).then((response) {
      Map result = json.decode(response.body);
      // assert(result['totalQuestionCount'] != null, 'result is empty.');
      assert(result['data'] != null, 'result is empty.');

      print('result ${result}');

      Map<String, int> convertMapQuestionsCount =
          Map<String, int>.from(result['data']);

      $mapOfTotalQuestionsCount.sink$(convertMapQuestionsCount);

      completer.complete(
        RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          // data: getTotalQuestionCount,
          data: convertMapQuestionsCount,
        ),
      );
    }).catchError((error) {
      GUtility.log('getTotalQuestionLength $error');

      completer.complete(
        RestfulResult(
          statusCode: STATUS.ERROR_CODE,
          message: 'getSelectedCountRandomQuestion $error',
        ),
      );
    });
    return completer.future;
  }

  ///
  // TODO : get selected count Question
  Future<RestfulResult> getSelectedCountRandomQuestion(int count) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, '${PATH.QUESTION_RANDOM_COUNT}/$count')
        : Uri.https(PATH.FORIEGN_URL, '${PATH.QUESTION_RANDOM_COUNT}/$count');

    http.get(query, headers: headers).then((response) {
      Map result = json.decode(response.body);
      assert(List.from(result['data']).isNotEmpty, 'result[data] is empty.');
      Map<String, MQuestion> mapOfQuestion = {};

      for (dynamic item in result['data']) {
        MQuestion convertQuestion = MQuestion.fromMap(item);
        mapOfQuestion[convertQuestion.id] = convertQuestion;
      }

      print('mapOfQuestion ${mapOfQuestion}');

      completer.complete(
        RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          data: mapOfQuestion,
        ),
      );
    }).catchError((error) {
      GUtility.log(error);
      completer.complete(
        RestfulResult(
          statusCode: STATUS.ERROR_CODE,
          message: 'getSelectedCountRandomQuestion $error',
        ),
      );
    });

    return completer.future;
  }

  ///
  ///

  Future<void> getWishQuestion() {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.QUESTION_WISH)
        : Uri.https(PATH.FORIEGN_URL, PATH.QUESTION_WISH);

    http.get(query, headers: headers).then((response) {
      if (response.statusCode != 200) {
        return completer.complete(
          RestfulResult(
            statusCode: response.statusCode,
            message: 'getWishQuestionError',
          ),
        );
      }
      Map result = json.decode(response.body);

      assert(List.from(result['data']).isNotEmpty, 'result[data] is empty.');

      Map<String, MQuestion> mapOfQuestion = {};

      for (dynamic item in result['data']) {
        MQuestion convertQuestion = MQuestion.fromMap(item);
        mapOfQuestion[convertQuestion.id] = convertQuestion;
      }

      $mapOfQuestion.sink$(mapOfQuestion);

      completer.complete(
        RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          data: mapOfQuestion,
        ),
      );
    }).catchError((error) {
      GUtility.log(error);
      completer.complete(
        RestfulResult(
          statusCode: STATUS.ERROR_CODE,
          message: 'getAllQuestionError $error',
        ),
      );
    });

    return completer.future;
  }

  Future<RestfulResult> getWishQuestionBySubject() {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.QUESTION_WISH_BY_SUBJECT)
        : Uri.https(PATH.FORIEGN_URL, PATH.QUESTION_WISH_BY_SUBJECT);

    http.get(query, headers: headers).then((response) {
      Map result = json.decode(response.body);
      Map<String, List<MQuestion>> mapOfWishQuestion =
          Map<String, List>.from(result['data']).map((key, value) {
        List<MQuestion> convertValue =
            value.map((e) => MQuestion.fromMap(e)).toList();
        return MapEntry(key, convertValue);
      });

      $mapOfWishQuestion.sink$(mapOfWishQuestion);

      completer.complete(
        RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          data: mapOfWishQuestion,
        ),
      );
    }).catchError((error) {
      GUtility.log('error $error');
      completer.complete(
        RestfulResult(
          statusCode: STATUS.ERROR_CODE,
          message: 'getAllQuestionError $error',
        ),
      );
    });

    return completer.future;
  }

  Future<RestfulResult> getFilteredBySubject({
    required List<String> subCategoryIds,
  }) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    String encodeData = jsonEncode({
      "subCategoryIds": subCategoryIds,
    });

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.FILTERED_QUESTION)
        : Uri.https(PATH.FORIEGN_URL, PATH.FILTERED_QUESTION);

    http.post(query, body: encodeData, headers: headers).then((response) {
      Map result = json.decode(response.body);
      List<MQuestion> questionList = [];

      for (dynamic item in result['data']) {
        MQuestion convertQuestion = MQuestion.fromMap(item);
        questionList.add(convertQuestion);
      }

      $questionList.sink$(questionList);
      print(questionList);

      completer.complete(
        RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          data: questionList,
        ),
      );
    }).catchError((error) {
      completer.complete(
        RestfulResult(
          statusCode: STATUS.ERROR_CODE,
          message: 'getFilteredQuestionError $error',
        ),
      );
      // GHelperNavigator.pushLogin();
    });

    //
    return completer.future;
  }

  Future<RestfulResult> getImage(String imageId) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    Map<String, String> queryParameters = {'id': imageId};

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, '${PATH.QUESTION_IMAGE}/', queryParameters)
        : Uri.https(
            PATH.FORIEGN_URL, '${PATH.QUESTION_IMAGE}/', queryParameters);

    http.get(query, headers: _headers).then((response) {
      String imageResult = base64Encode(response.bodyBytes);

      completer.complete(
        RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          data: imageResult,
        ),
      );
    }).catchError((error) {
      GUtility.log('question get Error $error');
    });

    return completer.future;
  }
}
