import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class RoomPage extends StatefulWidget {
  const RoomPage(this.room, {super.key});
  final Room room;

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
