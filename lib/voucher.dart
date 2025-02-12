import 'package:flutter/material.dart';

class voucher extends StatelessWidget {
  const voucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              VoucherCard(
                title: 'Welcome Offer',
                description: 'Get 10% off on your first order',
                code: 'WELCOME10',
                backgroundColor: Colors.pink.shade100,
              ),
              SizedBox(height: 20),
              VoucherCard(
                title: 'Weekend Special',
                description: '20% off on orders above ₹500',
                code: 'WEEKEND20',
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 20),
              VoucherCard(
                title: 'Birthday Treat',
                description: '15% off on your birthday',
                code: 'BIRTHDAY15',
                backgroundColor: Colors.pink.shade100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VoucherCard extends StatelessWidget {
  final String title;
  final String description;
  final String code;
  final Color backgroundColor;

  const VoucherCard({
    Key? key,
    required this.title,
    required this.description,
    required this.code,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0), 
      margin: EdgeInsets.symmetric(horizontal: 16.0), 
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.0), 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Code: $code',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Voucher Applied!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.pink,
                ),
                child: Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}