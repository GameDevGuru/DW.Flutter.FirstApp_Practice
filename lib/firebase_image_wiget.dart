import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseImageWiget extends StatelessWidget {
  final String imagePath = '/assets/pokemon_placeholder.png'; //?alt=media&token=34a82487-3175-4929-9504-7b2251c514da'

  Future<String> _getDownloadUrl() async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);

    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getDownloadUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading state
        }
        if (snapshot.hasError) {
          return Icon(Icons.error); // Error state
        }
        if (snapshot.hasData) {
          // 3. Use the URL with Image.network
          return Image.network(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        }
        return Container();
      },
    );
  }
}