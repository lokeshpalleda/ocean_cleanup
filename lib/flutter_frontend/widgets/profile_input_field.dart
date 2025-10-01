import 'package:flutter/material.dart';

Widget inputField(String label, IconData icon, TextEditingController controller,
    {bool isEmail = false}) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        suffixIcon: Icon(icon, color: Colors.black87),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black87, width: 2),
        ),
      ),
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid $label';
        }
        if (isEmail && !value.contains('@')) {
          return 'Enter a valid Email';
        }
        return null;
      },
    ),
  );
}
