import 'package:livekit_client/livekit_client.dart';

class LKServerGateway {
  static const String _url = '';
  static const RoomOptions _roomOptions = RoomOptions();

  static Future<Room> connect(String token) async {
    try {
      return await LiveKitClient.connect(
        _url,
        token,
        roomOptions: _roomOptions,
      );
    } catch (e) {
      rethrow;
    }
  }
}
