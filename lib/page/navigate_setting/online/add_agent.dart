import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  bool _isOnline = false; // Default value for online status

  Future<void> _addUser() async {
    try {
      await _firestore.collection('users').add({
        'id_agent': _emailController.text,
        'fullName': _fullNameController.text,
        'isOnline': _isOnline,
        'lastActive': FieldValue.serverTimestamp(),
      });
      print('User added successfully');
      // Clear input fields after adding
      _emailController.clear();
      _fullNameController.clear();
      _imageController.clear();
    } catch (e) {
      print('Failed to add user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Agent Action')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'ID agent'),
            ),
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            SwitchListTile(
              title: Text(_isOnline ? "Is Online" : "Off Online"),
              value: _isOnline,
              onChanged: (bool value) {
                setState(() {
                  _isOnline = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addUser,
              child: const Text('Add Agent Action'),
            ),
          ],
        ),
      ),
    );
  }
}
