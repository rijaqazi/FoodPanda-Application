import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String message;

  const ProfileScreen({
    required this.name,
    required this.email,
    required this.message,
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.pink, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo('Name', name),//method that create a row of labels and value
            const SizedBox(height: 10),
            _buildInfo('Email', email),
            const SizedBox(height: 10),
            _buildInfo('Message', message),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
