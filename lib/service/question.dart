part of 'lib.dart';

class ServiceQuestion {
  static ServiceQuestion? _instance;
  factory ServiceQuestion.getInstance() =>
      _instance ??= ServiceQuestion._internal();
  ServiceQuestion._internal();

  final TStream<int> $selectedIndex = TStream<int>();
  int get selectedIndex => $selectedIndex.lastValue;

  final TStream<List<MQuestion>> $questions = TStream<List<MQuestion>>()
    ..sink$([]);
  List<MQuestion> get questions => $questions.lastValue;

  final TStream<Map<String, MQuestion>> $mapOfQuestion =
      TStream<Map<String, MQuestion>>()..sink$({});

  Map<String, MQuestion> get mapOfQuestion => $mapOfQuestion.lastValue;

  final TStream<int> $totalQuestionCount = TStream<int>()..sink$(0);

  Future<RestfulResult> getTotalQuestionLength() {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    http
        .get(GUtility.getRequestUri(PATH.QUESTION_COUNTER), headers: headers)
        .then((response) {
      Map result = json.decode(response.body);
      assert(result['totalQuestionCount'] != null, 'result is empty.');
      assert(result['data'] != null, 'result is empty.');

      print('result ${result['data']}');

      int getTotalQuestionCount =
          int.parse(result['totalQuestionCount'].toString());
      $totalQuestionCount.sink$(getTotalQuestionCount);

      completer.complete(
        RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          data: getTotalQuestionCount,
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

    http
        .get(
            GUtility.getRequestUri(
                PATH.QUESTION_RANDOM_COUNT + count.toString()),
            headers: headers)
        .then((response) {
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

  Future<RestfulResult> getWishQuestion() {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    http
        .get(GUtility.getRequestUri(PATH.QUESTION_WISH), headers: headers)
        .then((response) {
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

  Future<RestfulResult> getFiltered({
    required String categoryID,
  }) async {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    String encodeData = jsonEncode({
      "subCategoryID": categoryID,
    });

    http
        .post(GUtility.getRequestUri(PATH.FILTERED_QUESTION),
            body: encodeData, headers: headers)
        .then((response) {
      Map result = json.decode(response.body);
      // assert(result['data'].length != 0);
      // ('result $result');
      List<MQuestion> questionList = [];

      for (dynamic item in result['data']) {
        MQuestion convertQuestion = MQuestion.fromMap(item);

        questionList.add(convertQuestion);
      }

      $questions.sink$(questionList);

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

  Future<RestfulResult> getImage(String imageID) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    http
        .get(GUtility.getRequestUri(PATH.QUESTION_IMAGE + imageID),
            headers: _headers)
        .then((response) {
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
