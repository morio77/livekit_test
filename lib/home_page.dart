import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String roomName = "";
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
      child: Container(
        color: Colors.black38,
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _userNameTextField() {
    return TextField();
  }

  Widget _roomSelectionDropdownButton() {
    return TextField();
  }

  Widget _enterRoomButton() {
    return const ElevatedButton(
      onPressed: null,
      child: Text('入室する'),
    );
  }
}
