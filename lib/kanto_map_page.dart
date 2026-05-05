import 'package:flutter/material.dart';

class KantoMapPage extends StatefulWidget {
  final String pageTitle;
  const KantoMapPage({super.key, required this.pageTitle});

  @override
  State<KantoMapPage> createState() => _KantoMapState();
}

class _KantoMapState extends State<KantoMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.pageTitle),
      ),
      body: Text("Coming Soon! See the Map of the Kanto Region!"),
    );
  }
}