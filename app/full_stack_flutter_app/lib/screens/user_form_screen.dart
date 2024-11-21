import 'package:flutter/material.dart';
import 'package:full_stack_flutter_app/models/user.dart';
import 'package:full_stack_flutter_app/services/user_service.dart';

class UserFormScreen extends StatefulWidget {
  final Function fetchUsers;
  UserFormScreen({required this.fetchUsers});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();

  String _name = '';
  String _email = '';
  int _age = 18;
  String _city = 'isb';
  String _gender = 'male';
  bool _employed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Name', (value) => _name = value, 'Name cannot be empty'),
                SizedBox(height: 16),
                _buildTextField('Email', (value) => _email = value, 'Email cannot be empty'),
                SizedBox(height: 16),
                _buildAgeField(),
                SizedBox(height: 16),
                _buildDropdown(),
                SizedBox(height: 16),
                _buildGenderSelection(),
                SizedBox(height: 16),
                _buildEmployedCheckbox(),
                SizedBox(height: 30),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom TextFormField for Name and Email
  Widget _buildTextField(String label, Function(String) onChanged, String validatorMessage) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      onChanged: onChanged,
      validator: (value) => value!.isEmpty ? validatorMessage : null,
    );
  }

  // Age input with validation
  Widget _buildAgeField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Age',
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => setState(() => _age = int.tryParse(value) ?? 18),
      validator: (value) => value!.isEmpty ? 'Age cannot be empty' : null,
    );
  }

  // Dropdown for city selection
  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _city,
      decoration: InputDecoration(
        labelText: 'City',
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (value) => setState(() => _city = value!),
      items: ['isb', 'lahore', 'karachi']
          .map((city) => DropdownMenuItem(value: city, child: Text(city)))
          .toList(),
    );
  }

  // Radio buttons for gender selection
  Widget _buildGenderSelection() {
    return Row(
      children: [
        Text('Gender: ', style: TextStyle(fontSize: 16, color: Colors.teal)),
        Radio<String>(
          value: 'male',
          groupValue: _gender,
          onChanged: (value) => setState(() => _gender = value!),
        ),
        Text('Male'),
        Radio<String>(
          value: 'female',
          groupValue: _gender,
          onChanged: (value) => setState(() => _gender = value!),
        ),
        Text('Female'),
      ],
    );
  }

  // Checkbox for employment status
  Widget _buildEmployedCheckbox() {
    return Row(
      children: [
        Text('Employed: ', style: TextStyle(fontSize: 16, color: Colors.teal)),
        Checkbox(
          value: _employed,
          onChanged: (value) => setState(() => _employed = value!),
        ),
        Text('Yes'),
      ],
    );
  }

  // Submit Button with custom style
  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: _submitForm,
      child: Text(
        'Submit',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Form submission logic
  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        name: _name,
        email: _email,
        age: _age,
        city: _city,
        gender: _gender,
        employed: _employed,
      );

      try {
        await _userService.createUser(newUser);
        widget.fetchUsers();  // Refresh the user list
        Navigator.pop(context);  // Go back to the list screen
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    }
  }

  // Show error dialog
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
}
