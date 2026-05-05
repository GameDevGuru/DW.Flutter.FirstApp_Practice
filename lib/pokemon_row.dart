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
    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0
        ),        
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: imageUrl != null
                ? Image.network(imageUrl!)
                : Image.asset('assets/images/pokemon_placeholder.png'),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.green, width: 4.0)
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [                    
                    const SizedBox(height: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}