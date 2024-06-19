import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user.dart';

class MAAPI {
  static const String baseUrl = "http://localhost:8000/api";
  static const String userApi = "/user";
  static const String allUsersApi = "/user/all";

  //Add method to call the API
  static Future<void> addUser(User newUser) async {
    //print('addUser()');

    var url = Uri.parse('$baseUrl$userApi');
    var response = await http.post(
      url,
      body: jsonEncode(newUser.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User added successfully');
    } else {
      print('Failed to add user: ${response.statusCode}');
    }
  }

  //Add method to call the API
  static Future<List<User>> getUsers() async {
    //print('getUsers()');

    var url = Uri.parse('$baseUrl$allUsersApi');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var users = jsonDecode(response.body);
      //Loop through users and create a list of User objects
      List<User> userList = [];
      for (var user in users) {
        //print('User: $user');
        userList.add(User.fromJson(user));
      }
      return userList;
    } else {
      print('Failed to get users: ${response.statusCode}');
      return [];
    }
  }

  //Add method to call the API
  static Future<void> deleteUser(String name) async {
    var url = Uri.parse('$baseUrl$userApi');
    var response = await http.delete(
      url,
      body: jsonEncode({'name': name}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else {
      print('Failed to delete user');
    }
  }

  //Add method to call the API
  static Future<void> updateUser(String oldName, String newName) async {
    var url = Uri.parse('$baseUrl$userApi');
    var response = await http.put(
      url,
      body: jsonEncode({'oldName': oldName, 'newName': newName}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Failed to update user');
    }
  }
}