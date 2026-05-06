import 'package:flutter/material.dart';
import 'package:pokedex_flutter_tutorial/pokemon_row.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PokedexPage extends StatefulWidget {
  final String pageTitle;

  const PokedexPage({super.key, required this.pageTitle});

  @override
  State<PokedexPage> createState() => _PokedexState();
}

class _PokedexState extends State<PokedexPage> {
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
      document: gql(r'''
      {
        allPokemon {
          id
          number
          name
          imageUrl
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
      '''),
    );

    final QueryResult pokemonData = await client.query(options);

    if (pokemonData.hasException) {
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
        backgroundColor: Colors.blueAccent,
        title: Text(widget.pageTitle),
      ),
      body: ListView.builder(
        itemCount: _pokemons.length,
        itemBuilder: (context, index) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final pokemon = _pokemons[index];
          final elementTypes = pokemon['pokemonType']['elementTypes'];
          return PokemonRow(
            name: pokemon['name'],
            number: pokemon['number'],
            type: [...elementTypes],
          );
        },
      ),
    );
  }
}
