import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  final String createUserUrl = "http://localhost:8800/user/create";  // Replace with your actual API URL
  final String getUserUrl = "http://localhost:8800/user";  // Replace with your actual API URL

Future<List<User>> getUsers() async {
  final response = await http.get(Uri.parse(getUserUrl));

  if (response.statusCode == 200) {
    // Decode the response body
    final Map<String, dynamic> data = json.decode(response.body);

    // Assuming the response has a 'users' key containing the list of users
    if (data.containsKey('users')) {
      List<dynamic> usersJson = data['users'];
      return usersJson.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('No "users" key found in the response');
    }
  } else {
    throw Exception('Failed to load users');
  }
}


  Future<void> createUser(User user) async {
    final response = await http.post(
      Uri.parse(createUserUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }
}
