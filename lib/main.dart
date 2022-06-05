import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LivekitView extends StatefulWidget {
  LivekitView({Key? key}) : super(key: key);

  @override
  State<LivekitView> createState() => _LivekitViewState();
}

class _LivekitViewState extends State<LivekitView> {
  VideoTrack? track;

  @override
  Widget build(BuildContext context) {
    if (track != null) {
      return VideoTrackRenderer(track!);
    } else {
      return Container(
        color: Colors.grey,
      );
    }
  }
}
