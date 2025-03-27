import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'db/services/user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserService userService = UserService();
  static const platform = MethodChannel('com.example.myapp/methods');

  MyApp({super.key});

  Future<void> callNativeMethod() async {
    try {
      final String result = await platform.invokeMethod('nativeMethod');
      print('Swift response: $result');
    } on PlatformException catch (e) {
      print('Failed to call native method: ${e.message}');
    }
  }

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  callNativeMethod();
                },
                child: Icon(Icons.arrow_back),
              ),
              FloatingActionButton(
                onPressed: () async {
                  print("Sddsdsd");
                  await userService.insertUser(
                      "Sey3 Ipaye", "Seyipaye3@example.com");
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
