import 'package:flutter/material.dart';
import 'package:shopping_cart/profile.dart';

class Feed_back extends StatefulWidget {
  const Feed_back({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<Feed_back> {
  //texteditingcontroller text retrieve krta
  //_namecontroller instance od tec
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    //dispose memory free karaha 
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    //parent class resource release 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Form'),
        backgroundColor: Colors.pink, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'We value your feedback!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 20),
            
            TextField(//box for input
              controller: _nameController, //name store
              decoration: const InputDecoration( 
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,  //email store 
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress, // @availiable no proble
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      name: _nameController.text,//retrieving text 
                      email: _emailController.text,
                      message: _messageController.text,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color:Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
