import 'package:flutter/material.dart';

class HomePageTextField extends StatefulWidget {
  const HomePageTextField({
    super.key,
    required this.wingsController,
    required this.quantity,
  });

  final TextEditingController wingsController;
  final String quantity;

  @override
  State<HomePageTextField> createState() => _HomePageTextFieldState();
}

class _HomePageTextFieldState extends State<HomePageTextField> {
  void increment() {
    int currentValue = int.tryParse(widget.wingsController.text) ?? 0;
    setState(() {
      widget.wingsController.text = (currentValue + 1).toString();
    });
  }

  void decrement() {
    int currentValue = int.tryParse(widget.wingsController.text) ?? 0;
    if (currentValue > 0) {
      setState(() {
        widget.wingsController.text = (currentValue - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Decrement Button
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1ABC9C), // Teal color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: decrement,
              icon: const Icon(Icons.remove),
              color: Colors.white,
            ),
          ),

          // Text Field
          Container(
            width: 200, // Moderately long text field width
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFD2B48C), // Light brown color
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // Shadow position
                ),
              ],
            ),
            child: TextField(
              controller: widget.wingsController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Text color
              ),
              decoration: InputDecoration(
                labelText: widget.quantity,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 8, 8, 8), // Purple label color
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10), // Padding inside the TextField
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF8E44AD), // Purple border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5), // Soft background color
              ),
            ),
          ),

          // Increment Button
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF8E44AD), // Purple color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: increment,
              icon: const Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
