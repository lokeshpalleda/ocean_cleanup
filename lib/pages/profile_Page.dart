import 'package:flutter/material.dart';
import 'package:ocean_clean/pages/question_page.dart';
import 'package:ocean_clean/widgets/profile_input_field.dart';

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
  final TextEditingController _locationController = TextEditingController();
  String? _selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        title: const Text('Volunteer Participation'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                    inputField('Email', Icons.email, _emailController, isEmail: true),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DropdownButtonFormField<String>(
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
                        items: [
                          'Beach CleanUp',
                          'Awareness Campaign',
                          'Ocean CleanUp',
                        ].map((event) {
                          return DropdownMenuItem<String>(
                            value: event,
                            child: Text(event),
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
                      ),
                    ),
                    inputField('Location', Icons.location_on, _locationController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Future.delayed(const Duration(milliseconds: 500));
                            // await FirebaseFirestore.instance.collection('volunteers').add({
                            //   'name': _nameController.text.trim(),
                            //   'phone': _phoneController.text.trim(),
                            //   'email': _emailController.text.trim(),
                            //   'event': _selectedEvent,
                            //   'location': _locationController.text.trim(),
                            // });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Volunteer info submitted!')),
                            );

                            _formKey.currentState!.reset();
                            setState(() {
                              _selectedEvent = null;
                            });
                            _nameController.clear();
                            _phoneController.clear();
                            _emailController.clear();
                            _locationController.clear();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to save information')),
                            );
                          }
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
    );
  }
}
