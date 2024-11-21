import 'package:flutter/material.dart';
import 'package:full_stack_flutter_app/models/user.dart';
import 'package:full_stack_flutter_app/services/user_service.dart';
import 'package:full_stack_flutter_app/screens/user_form_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService _userService = UserService();
  List<User> _users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<User> users = await _userService.getUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(e.toString());
    }
  }

  _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.teal, // Button color (use backgroundColor)
    foregroundColor: Color(0xFFFFFFFF), // Text color
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserFormScreen(fetchUsers: _fetchUsers)),
    );
  },
  child: Text(
    'Create User',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  ),
),

                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.1),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              user.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text("Email: ${user.email}", style: TextStyle(fontSize: 14)),
                                Text("Age: ${user.age}", style: TextStyle(fontSize: 14)),
                                Text("City: ${user.city}", style: TextStyle(fontSize: 14)),
                                Text("Gender: ${user.gender}", style: TextStyle(fontSize: 14)),
                                Text("Employed: ${user.employed ? 'Yes' : 'No'}", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal.withOpacity(0.2),
                              child: Icon(Icons.person, color: Colors.teal),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
