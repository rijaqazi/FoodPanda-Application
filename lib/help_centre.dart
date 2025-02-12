import 'package:flutter/material.dart';

class HelpCentre extends StatelessWidget {
  const HelpCentre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Centre'),
        backgroundColor: Colors.pink, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Need Help?'),
            const SizedBox(height: 16.0),
            const Text(
              'Find answers to common questions and get in touch with our support team.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24.0),
            _buildSectionTitle('Frequently Asked Questions'),
            const SizedBox(height: 10.0),
            _buildFaqItem('How do I place an order?', 'Follow these simple steps...'),
            _buildFaqItem('What are the payment options?', 'We accept...'),
            _buildFaqItem('How can I track my order?', 'Track your order in real-time...'),
            const SizedBox(height: 24.0),
            _buildSectionTitle('Contact Us'),
            const SizedBox(height: 10.0),
            _buildContactRow(Icons.phone, '+123 456 7890'),
            const SizedBox(height: 10.0),
            _buildContactRow(Icons.email, 'support@yourcompany.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(answer),
        const SizedBox(height: 15.0),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24.0),
        const SizedBox(width: 10.0),
        Text(
          text,
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}