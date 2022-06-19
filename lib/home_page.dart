import 'package:flutter/material.dart';
import 'package:livekit_test/token_server_gateway.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 黒いボックス
                _blackContainer(),

                // ユーザ名入力部分
                _userNameTextField(),

                // ルーム選択部分
                _roomSelectionDropdownButton(),

                // 入室ボタン
                _enterRoomButton(),
              ],
            ),
          ),

          // 入室中は全体をマスクし、くるくるインジケータを出す
          if (isEnteringRoom)
            Container(
              color: Colors.grey.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            ),
          if (isEnteringRoom) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _blackContainer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Hero(
        tag: 'videoContainer',
        child: Container(
          color: Colors.black38,
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  Widget _userNameTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'ユーザ名',
          prefixIcon: Icon(Icons.face),
          // suffixIcon: Icon(Icons.face_outlined),
        ),
        controller: userNameController,
      ),
    );
  }

  Widget _roomSelectionDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          setState(() {
            isEnteringRoom = true;
          });

          var token = await TokenServerGateway.generateToken();
        } catch (e) {
          return;
        } finally {
          setState(() {
            isEnteringRoom = false;
          });
        }
      },
      child: const Text('入室する'),
    );
  }
}
