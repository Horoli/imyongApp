part of 'lib.dart';

class ServiceQuestion {
  static ServiceQuestion? _instance;
  factory ServiceQuestion.getInstance() =>
      _instance ??= ServiceQuestion._internal();
  ServiceQuestion._internal();

  final TStream<int> $selectedIndex = TStream<int>();
  int get selectedIndex => $selectedIndex.lastValue;

  final TStream<List<MQuestion>> $questions = TStream<List<MQuestion>>();
  List<MQuestion> get questions => $questions.lastValue;

  Future<RestfulResult> getFilteredQuestion({
    required String categoryID,
  }) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: hiveMGuestLogin.values.first.token,
    );

    String encodeData = jsonEncode({
      "subCategoryID": categoryID,
    });

    http
        .post(getRequestUri(PATH.FILTERED_QUESTION),
            body: encodeData, headers: headers)
        .then((response) {
      Map result = json.decode(response.body);
      assert(result['data'].length != 0);
      List<MQuestion> questionList = [];

      for (dynamic item in result['data']) {
        MQuestion convertQuestion = MQuestion.fromMap(item);

        questionList.add(convertQuestion);
      }

      $questions.sink$(questionList);

      completer.complete(
          RestfulResult(statusCode: STATUS.SUCCESS_CODE, message: 'ok'));
    }).catchError((error) {
      print('error $error');
      // GHelperNavigator.pushLogin();
    });

    //
    return completer.future;
  }
}
