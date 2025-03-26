import 'package:flutter/material.dart';
import 'db/services/user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserService userService = UserService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drift Singleton Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Drift DB Example')),
        body: FutureBuilder(
          future: userService.fetchAllUsers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            final users = snapshot.data as List;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  subtitle: Text(users[index].email),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await userService.insertUser(
                "Yash Tiwari", "yashtiwari@example.com");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
