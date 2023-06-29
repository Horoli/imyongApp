part of '/common.dart';

const EdgeInsetsGeometry commonPadding = EdgeInsets.all(4);

ScaffoldFeatureController showSnackBar({
  required String msg,
  required BuildContext context,
  Duration duration = const Duration(milliseconds: 1000),
}) {
  SnackBar snackBar = SnackBar(
    content: Text(msg),
    duration: duration,
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void buildErrorDialog(
  String message,
  int statusCode,
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Center(child: Text('$statusCode')).expand(),
              Center(child: Text(message)).expand(),
            ],
          ),
        ),
      );
    },
  );

  // Timer(const Duration(milliseconds: 2000), () {
  //   GHelperNavigator.pushLogin();
  // });
}

Widget buildBorderContainer({
  Widget? child,
  double? width,
  double? height,
}) {
  return Padding(
    padding: commonPadding,
    child: Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: child,
      ),
    ),
  );
}

Widget buildElevatedButton({
  double? height,
  double? width,
  required void Function() onPressed,
  required Widget child,
  EdgeInsetsGeometry padding = commonPadding,
  Color? color,
}) {
  return Container(
    padding: padding,
    height: height,
    width: width,
    child: ElevatedButton(
      style: ButtonStyle(
        elevation:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return 16;
          }
          return 8;
        }),
        backgroundColor: MaterialStateProperty.all(color),
        // side: MaterialStateProperty.all(BorderSide(
        // width: 1,
        // color: Color(0xFF000000),
        // )),
      ),
      child: child,
      onPressed: onPressed,
    ),
  );
}

Widget buildTextField({
  TextEditingController? ctr,
  bool obscureText = false,
  required String label,
  String hint = '',
  bool readOnly = false,
}) {
  return Padding(
    padding: commonPadding,
    child: TextFormField(
      controller: ctr,
      // expands: true,
      // maxLines: null,
      // maxLength: null,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 40),
        labelText: label,
        hintText: hint,
      ),
    ),
  );
}

Widget buildText(
  String text, {
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(fontWeight: fontWeight),
  );
}
