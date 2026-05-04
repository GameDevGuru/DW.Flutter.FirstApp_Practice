import 'package:flutter/material.dart';

class PokemonRow extends StatelessWidget {
  final String name;
  final int number;
  final List<String> type;
  final String? imageUrl;

  const PokemonRow({
    super.key,
    required this.name,
    required this.number,
    required this.type,
    this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: imageUrl != null
              ? Image.network(imageUrl!)
              : const FlutterLogo(),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  number.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  type.join(', '),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}