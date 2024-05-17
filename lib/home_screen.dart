import 'package:flutter/material.dart';
import 'api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  Map<String, dynamic> pokemonData = {}; // Inicializando pokemonData como un Map vacío
  bool isLoading = false;

  void fetchPokemonData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await apiService.fetchPokemon('pikachu');
      setState(() {
        pokemonData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Info'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : pokemonData != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name: ${pokemonData['name']}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Image.network(pokemonData['sprites']['front_default']),
                      SizedBox(height: 10),
                      Text(
                        'Height: ${pokemonData['height']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Weight: ${pokemonData['weight']}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  )
                : Text('Failed to load Pokémon data'),
      ),
    );
  }
}
