import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ocean_clean/flutter_frontend/user_side/pages/question_page.dart';
import 'package:ocean_clean/flutter_frontend/user_side/widgets/profile_input_field.dart';
import 'package:ocean_clean/flutter_frontend/login_credentials/auth_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedEvent;

  Future<List<String>> fetchEventTitles() async {
  final url = Uri.parse(" https://ocean-cleanup.onrender.com/api/admin/events"); // change to your backend endpoint
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    // assuming backend sends something like:
    // [{ "title": "Beach CleanUp" }, { "title": "Awareness Campaign" }]
    return data.map((e) => e['title'].toString()).toList();
  } else {
    throw Exception('Failed to load events');
  }
}

  Future<void> submitVolunteer() async {
    final url = Uri.parse(" https://ocean-cleanup.onrender.com/api/volunteer");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": _nameController.text.trim(),
        "phone": _phoneController.text.trim(),
        "email": _emailController.text.trim(),
        "option": _selectedEvent,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Volunteer info submitted!")),
      );
      _formKey.currentState!.reset();
      setState(() => _selectedEvent = null);
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.body}")),
      );
    }
  }

   void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // cancel
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AuthScreen()),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        title: const Text('Volunteer Participation'),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Frontpage()),
              );
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/background.jpg', fit: BoxFit.fill),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Volunteer Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 20),
                    inputField('Name', Icons.person, _nameController),
                    inputField('Phone', Icons.phone, _phoneController),
                    inputField('Email', Icons.email, _emailController,
                        isEmail: true),
                    Padding(
  padding: const EdgeInsets.all(12.0),
  child: FutureBuilder<List<String>>(
    future: fetchEventTitles(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Text('No events available');
      }

      final eventTitles = snapshot.data!;

      return DropdownButtonFormField<String>(
        value: _selectedEvent,
        decoration: InputDecoration(
          labelText: 'Choose Event',
          suffixIcon: const Icon(Icons.event, color: Colors.black87),
          labelStyle: const TextStyle(color: Colors.black87),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black87, width: 2),
          ),
        ),
        items: eventTitles.map((title) {
          return DropdownMenuItem<String>(
            value: title,
            child: Text(title),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedEvent = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please choose an event";
          }
          return null;
        },
      );
    },
  ),
),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await submitVolunteer();
                        }
                      },
                      child: const Text('Add Volunteer'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      /// 🔹 Floating Logout Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: _showLogoutDialog,
        child: const Icon(Icons.logout), // Logout icon
      ),
    );
  }
}
