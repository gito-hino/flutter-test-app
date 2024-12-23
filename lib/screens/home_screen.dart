import 'package:flutter/material.dart';
import 'package:flutter_test_app/repositories/pokemon_repository.dart';
import 'package:flutter_test_app/repositories/api_client.dart';

// ホーム画面のウィジェット

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PokemonRepository repository;
  late Future<List<Map<String, dynamic>>> pokemonData;

  @override
  void initState() {
    super.initState();
    final apiClient = ApiClient();

    repository = PokemonRepository(apiClient);
    // 非同期で取得するポケモンデータ
    pokemonData = repository.fetchAllPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("ホーム画面"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: pokemonData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // データの取得中
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // エラーの場合
            return Center(child: Text("エラーが発生しました"));
          } else if (snapshot.hasData) {
            // データが正常に取得できた場合
            final pokemonList = snapshot.data!;
            return ListView.builder(
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];
                final name = pokemon['name'];
                final imageUrl = pokemon['sprites']['front_default'];

                return ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(name),
                );
              },
            );
          } else {
            // データが空の場合
            return Center(child: Text("データがありません"));
          }
        },
      ),
    );
  }
}
