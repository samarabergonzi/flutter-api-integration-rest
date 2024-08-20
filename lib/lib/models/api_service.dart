// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/users";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw Exception("Falha ao carregar usuários");
    }
  }
}