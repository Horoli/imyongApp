part of 'lib.dart';

@HiveType(typeId: HIVE_ID.GUEST_LOGIN)
class MGuestLogin {
  late String token;
  // late int expireAt;

  MGuestLogin({
    required this.token,
  });

  factory MGuestLogin.fromMap(Map<String, dynamic> item) {
    String token = item['token'] ?? '';
    return MGuestLogin(token: token);
  }

  @override
  Map<String, dynamic> get map => {
        'token': token,
      };

  MGuestLogin copyWith({
    String? token,
  }) =>
      MGuestLogin(
        token: token ?? this.token,
      );
}

class MGuestLoginAdapter extends TypeAdapter<MGuestLogin> {
  @override
  final typeId = HIVE_ID.GUEST_LOGIN;

  @override
  MGuestLogin read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MGuestLogin(
      token: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MGuestLogin obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }
}
