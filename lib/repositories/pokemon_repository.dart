import 'api_client.dart';

// ポケモンのデータを取得するリポジトリ

class PokemonRepository {
  final ApiClient apiClient;

  PokemonRepository(this.apiClient);

  final List<String> pokemonNames = [
    'pikachu',
    'eevee',
    'mew',
  ];

  // 全てのポケモンデータを取得する関数
  Future<List<Map<String, dynamic>>> fetchAllPokemonData() async {
    return Future.wait(
      pokemonNames.map((name) => apiClient.fetchPokeData(name)),
    );
  }
}