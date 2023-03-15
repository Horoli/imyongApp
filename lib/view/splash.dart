part of '/common.dart';

class ViewSplash extends StatefulWidget {
  const ViewSplash({Key? key}) : super(key: key);

  @override
  _ViewSplashState createState() => _ViewSplashState();
}

class _ViewSplashState extends State<ViewSplash>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: buildElevatedButton(
        child: Text(''),
        onPressed: () async {
          String guestID = GServiceGuest.guest.id;
          RestfulResult result = await GServiceGuestLogin.login(guestID);
          print(result.data);
          print(result.isSuccess);

          if (result.isSuccess) {
            push();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    String guestID = '';

    // TODO : must delete
    Timer(Duration(milliseconds: 1000), () async {
      if (hiveMGuestLogin.isEmpty) {
        guestID = newUUID();
      } else {
        guestID = hiveMGuestLogin.keys.first;
      }

      print('guestID $guestID');
      RestfulResult result = await GServiceGuest.post(uuid: guestID);
      print('result ${result.data}');
      print('result ${result.isSuccess}');
    });

    // Timer(Duration(milliseconds: 3000), () {
    // hiveMGuestLogin.put(GServiceGuest.guest.id, MGuestLogin(token: ''));
    //   print('hiveMGuestLogin ${hiveMGuestLogin.keys}');
    // });
  }

  void push() {
    Navigator.pushNamedAndRemoveUntil(context, ROUTER.MAIN, (route) => false);
  }
}
