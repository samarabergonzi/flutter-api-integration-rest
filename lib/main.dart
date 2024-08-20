// lib/main.dart
import 'package:app_rest/lib/models/api_service.dart';
import 'package:app_rest/lib/models/user.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Integration Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> futureUsers;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureUsers = apiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Erro: ${snapshot.error}");
            } else if (snapshot.hasData) {
              List<User>? users = snapshot.data;
              return ListView.builder(
                itemCount: users?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users![index].name),
                    subtitle: Text(users[index].email),
                  );
                },
              );
            } else {
              return Text("Nenhum usuário encontrado.");
            }
          },
        ),
      ),
    );
  }
}