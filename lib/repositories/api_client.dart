import 'package:dio/dio.dart';
import 'dart:io';

// APIクライアント

class ApiClient {
  final Dio dio = Dio();

  // ポケモンデータを取得
  Future<Map<String, dynamic>> fetchPokeData(String name) async {
    try {
      final response = await dio.get(
        'https://pokeapi.co/api/v2/pokemon/$name'
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('データの読み込みに失敗しました');
      }
    } catch(e) {
      throw Exception('データの読み込みに失敗しました: $e');
    }
  }
}