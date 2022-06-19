import 'package:flutter/material.dart';
import 'package:livekit_test/http_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController userNameController = TextEditingController();
  String roomName = 'ルーム1';
  bool isEnteringRoom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livekitデモ'),
      ),
      body: Column(
        children: [
          // 黒いボックス
          _blackContainer(),

          // ユーザ名入力部分
          _userNameTextField(),

          // ルーム選択部分
          _roomSelectionDropdownButton(),

          // 入出ボタン
          _enterRoomButton(),
        ],
      ),
    );
  }

  Widget _blackContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: 'videoContainer',
        child: Container(
          color: Colors.black38,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  Widget _userNameTextField() {
    return TextField(
      controller: userNameController,
    );
  }

  Widget _roomSelectionDropdownButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButton<String>(
        value: roomName,
        items: const [
          DropdownMenuItem(value: 'ルーム1', child: Text('ルーム1')),
          DropdownMenuItem(value: 'ルーム2', child: Text('ルーム2')),
          DropdownMenuItem(value: 'ルーム3', child: Text('ルーム3')),
        ],
        onChanged: (String? value) {
          setState(() {
            roomName = value ?? roomName;
          });
        },
      ),
    );
  }

  Widget _enterRoomButton() {
    return ElevatedButton(
      onPressed: () async {
        try {
          var token = await TokenServerGateWay.generateToken();
        } catch (e) {
          return;
        }
      },
      child: const Text('入室する'),
    );
  }
}
