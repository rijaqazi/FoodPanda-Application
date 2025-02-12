import 'package:flutter/material.dart';
import 'package:shopping_cart/product.dart';

class PlaceOrderScreen extends StatefulWidget {
  final Cart cart;

  const PlaceOrderScreen({required this.cart});

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String _selectedAddress = '';
  String _selectedPaymentMethod = 'Cash On Delivery'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter Address',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _selectedAddress = value),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
          
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue!;
                });
              },
              items: [
                const DropdownMenuItem(
                  value: 'Cash On Delivery',
                  child: Text('Cash On Delivery'),
                ),
                const DropdownMenuItem(
                  value: 'Card',
                  child: Text('Card'),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Select Payment Method',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: _selectedAddress.isEmpty
                  ? null
                  : () => _placeOrder(context),
              icon: const Icon(Icons.shopping_cart_checkout),
              label: const Text('Place Order'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50.0),
                backgroundColor: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));


    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: const Text(
          'Order Placed!',
          style: TextStyle(color: Colors.green),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Your order is being prepared. You will receive confirmation shortly.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
           
            const Icon(Icons.check_circle_outline, size: 50.0, color: Colors.green),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('Go to Home'),
          ),
        ],
      ),
    );
  }
}


class AddressForm extends StatefulWidget {
  final Function(String) onAddressSelected;

  const AddressForm({required this.onAddressSelected});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _addressController,
      decoration: const InputDecoration(
        labelText: 'Enter Address',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        widget.onAddressSelected(value);
      },
    );
  }
}


class PaymentMethodSelector extends StatefulWidget {
  final Function(String) onPaymentMethodSelected;

  const PaymentMethodSelector({required this.onPaymentMethodSelected});

  @override
  _PaymentMethodSelectorState createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String _selectedMethod = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedMethod,
      onChanged: (String? newValue) {
        setState(() {
          _selectedMethod = newValue!;
          widget.onPaymentMethodSelected(_selectedMethod);
        });
      },
      items: [
        DropdownMenuItem(
          value: 'Cash On Delivery',
          child: const Text('Cash On Delivery'),
        ),
        DropdownMenuItem(
          value: 'Card',
          child: const Text('Card'),
        ),
        
      ],
      decoration: const InputDecoration(
        labelText: 'Select Payment Method',
        border: OutlineInputBorder(),
      ),
    );
  }
}