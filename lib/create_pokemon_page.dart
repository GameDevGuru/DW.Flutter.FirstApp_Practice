import 'package:flutter/material.dart';

class CreatePokemonPage extends StatefulWidget {
  final String pageTitle;
  const CreatePokemonPage({super.key, required this.pageTitle});

  @override
  State<CreatePokemonPage> createState() => _CreatePokemonState();
}

class _CreatePokemonState extends State<CreatePokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.pageTitle),
      ),
      body: Text("Coming Soon! Be Able to Create Your Own Pokemon!"),
    );
  }
}