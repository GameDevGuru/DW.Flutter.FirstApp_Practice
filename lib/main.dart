import 'package:flutter/material.dart';
import 'package:pokedex_flutter_tutorial/pokemon_row.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();

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
        colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: HomePage(title: "All Your Pokemon"),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _PokedexState();
}

class _PokedexState extends State<HomePage> {
  List<dynamic> _pokemons = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchPokemon();
  }
  
  Future<void> _fetchPokemon() async {
    GraphQLClient client = GraphQLProvider.of(context).value;

    final QueryOptions options = QueryOptions(
      document:gql(r'''
      {
        allPokemon {
          id
          number
          name
          pokemonType {
            id
            name
            elementTypes
          }
          stats {
            hp
            speed
            stamina
            shiny
          }
          attackList {
            id
            name
            pp
          }
        }
      }
      ''')
    );

    final QueryResult pokemonData = await client.query(options);

    if(pokemonData.hasException) {
      print(pokemonData.exception);
    } else {
      setState(() {
        _pokemons = pokemonData.data?['allPokemon'] ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _pokemons.length,
        itemBuilder: (context, index) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final pokemon = _pokemons[index];
            final elementTypes = pokemon['pokemonType']['elementTypes'];
            return PokemonRow(name: pokemon['name'], number: pokemon['number'], type: [...elementTypes]);
          }
        )
    );
  }
}
