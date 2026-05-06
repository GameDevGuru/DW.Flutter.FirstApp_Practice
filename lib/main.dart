import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';

void main() async {
  await initHiveForFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  final HttpLink httpLink = HttpLink("https://localhost:5001/graphql/");

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore())),
  );
  
  runApp(MainApp(client: client));
}

class MainApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MainApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: "Pokedex",
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple)
        ),
        home: HomePage(),
      ),
    );
  }
}