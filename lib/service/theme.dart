part of 'lib.dart';

class ServiceTheme {
  static ServiceTheme? _instance;
  factory ServiceTheme.getInstance() => _instance ??= ServiceTheme._internal();

  ServiceTheme._internal();

  late final TStream<ThemeData> $theme = TStream<ThemeData>();
  ThemeData get theme => $theme.lastValue;

  Future<void> fetch() async {
    // bool storageIsOpen = localStorage.getItem('theme') != null;
    bool storageIsOpen = GSharedPreferences.getInt('theme') != null;
    storageIsOpen ? _initStorage() : _firstInitStorage();
  }

  void _initStorage() {
    print('open');
    // int index = localStorage.getItem('theme');
    int index = GSharedPreferences.getInt('theme')!;
    print('open index $index');
    $theme.sink$(THEME.THEMEDATA_LIST[index]);
  }

  void _firstInitStorage() {
    print('최초 실행시에만 도ㅓㅣ야함');
    GSharedPreferences.setInt('theme', 0);
    $theme.sink$(THEME.THEMEDATA_LIST[0]);
  }

  void update(THEME.Type type) {
    int index = THEME.TYPE_LIST.indexOf(type);
    // localStorage.setItem('theme', index);
    GSharedPreferences.setInt('theme', index);
    // print('update ${localStorage.getItem('theme')}');
    $theme.sink$(THEME.THEMEDATA_LIST[index]);
  }
}
