part of 'lib.dart';

class ServiceSubCategory {
  static ServiceSubCategory? _instance;
  factory ServiceSubCategory.getInstance() =>
      _instance ??= ServiceSubCategory._internal();

  ServiceSubCategory._internal();

  final TStream<List<MSubCategory>> $subCategory =
      TStream<List<MSubCategory>>();
  List<MSubCategory> get subCategory => $subCategory.lastValue;

  final TStream<Map<String, MSubCategory>> $allSubCategory =
      TStream<Map<String, MSubCategory>>();
  Map<String, MSubCategory> get allSubCategory => $allSubCategory.lastValue;

  TStream<Map<String, List<String>>> $mapOfSubjectProgress =
      TStream<Map<String, List<String>>>();

  // TODO : DEV CODE // subCategories의 전체 데이터를
  // 한번 가져와야 데이터를 활용할 수 있음. 가져 온뒤 별도의 stream에 저장
  Future<RestfulResult> getAll() {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    Map<String, String> queryParameters = {"map": "map"};

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.SUBCATEGORY, queryParameters)
        : Uri.https(PATH.FOREIGN_URL, PATH.SUBCATEGORY, queryParameters);

    http.get(query, headers: _headers).then((value) {
      Map result = json.decode(value.body);
      Map<String, MSubCategory> convertResult = {};
      for (dynamic item in result['data'].keys) {
        String convertItem = item.toString();
        MSubCategory convertCategory =
            MSubCategory.fromMap(result['data'][item]);
        convertResult[convertItem] = convertCategory;
      }

      $allSubCategory.sink$(convertResult);

      completer.complete(
          RestfulResult(statusCode: STATUS.SUCCESS_CODE, message: 'ok'));
    }).catchError((error) {
      GUtility.log('getAll error ${error}');
    });
    return completer.future;
  }

  Future<RestfulResult> get({String parent = '', bool isNoChildren = false}) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();
    // selectedCategoriesId = [];

    // parent가 빈값이면 /subcategory(url),
    // parent에 입력 값이 있으면 /category?id=$parent(query)
    // String query =
    //     parent == '' ? PATH.SUBCATEGORY : '${PATH.CATEGORY_QUERY}$parent';
    // if (isNoChildren) {
    //   query = 'nochildrencategory';
    // }

    // print(HEADER.TOKEN);
    // print(GSharedPreferences.getString(HEADER.LOCAL_TOKEN));

    final Map<String, String> _headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    // print('_headers $_headers');

    Map<String, String> queryParameters = {'parent': parent};

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.CATEGORY, queryParameters)
        : Uri.https(PATH.FOREIGN_URL, PATH.CATEGORY, queryParameters);

    // http.get(GUtility.getRequestUri(query), headers: _headers).then(
    http.get(query, headers: _headers).then(
      (response) {
        Map result = json.decode(response.body);

        print('result $result');

        List<MSubCategory> subList = [];
        for (dynamic item in List.from(result['data'])) {
          subList.add(MSubCategory.fromMap(item));
        }

        GUtility.log('subList $subList');

        $subCategory.sink$(subList);

        completer.complete(RestfulResult(
          statusCode: STATUS.SUCCESS_CODE,
          message: 'ok',
          data: subList,
        ));
      },
    ).catchError((error) {
      GUtility.log('error $error');
      // GHelperNavigator.pushLogin();
    });

    return completer.future;
  }

  //
  Future<RestfulResult> post({
    required String name,
    BuildContext? context,
    String parent = '',
  }) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    String encodeData = jsonEncode({
      "name": name,
      "parent": parent,
    });

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.CATEGORY)
        : Uri.https(PATH.FOREIGN_URL, PATH.CATEGORY);

    http.post(query, body: encodeData, headers: headers).then((response) {
      Map result = json.decode(response.body);

      // name이 입력되지 않았으면 error return
      if (name == '') {
        GUtility.log('statusCode : ${response.statusCode}');
        return completer.complete(RestfulResult.fromMap(
          result,
          response.statusCode,
        ));
      }

      return completer.complete(RestfulResult.fromMap(
        result,
        response.statusCode,
      ));
    }).catchError((error) {});

    return completer.future;
  }

  Future<RestfulResult> delete({
    required String id,
  }) {
    Completer<RestfulResult> completer = Completer<RestfulResult>();

    final Map<String, String> headers = GUtility.createHeaders(
      tokenKey: HEADER.TOKEN,
      tokenValue: GSharedPreferences.getString(HEADER.LOCAL_TOKEN),
    );

    String encodeData = jsonEncode({
      "id": id,
    });

    Uri query = PATH.IS_LOCAL
        ? Uri.http(PATH.LOCAL_URL, PATH.CATEGORY)
        : Uri.https(PATH.FOREIGN_URL, PATH.CATEGORY);

    http.delete(query, body: encodeData, headers: headers).then((response) {
      Map result = json.decode(response.body);
      return completer.complete(
        RestfulResult.fromMap(
          result,
          response.statusCode,
        ),
      );
    });

    return completer.future;
  }
}
