import 'package:flutter/material.dart';

import 'api.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mike\'s Test App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  List<User> existingUsers = [];

  @override
  void initState() {
    super.initState();

     // Add a call to the API to get the list of users
    MAAPI.getUsers().then((users) {
      setState(() {
        existingUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Add a text box and a button
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User\'s name',
                ),
                controller: nameController,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                  User newUser = User(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  MAAPI.addUser(newUser);

                  setState(() {
                    existingUsers.add(newUser);
                    nameController.text = '';
                    emailController.text = '';
                    passwordController.text = '';
                  });

                  // Add a snackbar to show the name entered
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('User ${nameController.text} added.'),
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 20),
              const Text('Existing Users:', style: TextStyle(fontSize: 20)),
              for (User user in existingUsers)
                Text('${user.name} - ${user.email}'),
            ],
          ),
        ),
      ),
    );
  }
}

