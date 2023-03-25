part of 'lib.dart';

class ServiceQuestion {
  static ServiceQuestion? _instance;
  factory ServiceQuestion.getInstance() =>
      _instance ??= ServiceQuestion._internal();
  ServiceQuestion._internal();

  TStream<List<MQuestion>> $question = TStream<List<MQuestion>>();
  List<MQuestion> get question => $question.lastValue;

  Future<RestfulResult> getFilteredQuestion({
    required String categoryID,
  }) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> _headers = createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: hiveMGuestLogin.values.first.token,
    );

    String _encodeData = jsonEncode({
      "subCategoryID": categoryID,
    });

    http
        .post(getRequestUri(PATH.FILTERED_QUESTION),
            body: _encodeData, headers: _headers)
        .then((response) {
      Map result = json.decode(response.body);
      List<MQuestion> questionList = [];

      for (dynamic item in result['data']) {
        MQuestion convertQuestion = MQuestion.fromMap(item);
        questionList.add(convertQuestion);
      }

      $question.sink$(questionList);

      completer.complete(
          RestfulResult(statusCode: STATUS.SUCCESS_CODE, message: 'ok'));

      if (result['statusCode'] == 403) {
        // GHelperNavigator.pushLogin();
        return Error();
      }
    });

    //
    return completer.future;
  }
}
