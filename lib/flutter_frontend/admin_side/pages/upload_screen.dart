import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _pickedImage;

  // Pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  // Pick date
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  Future<void> _submitData() async {
  if (_titleController.text.isEmpty ||
      _dateController.text.isEmpty ||
      _latController.text.isEmpty ||
      _longController.text.isEmpty ||
      _descriptionController.text.isEmpty ||
      _pickedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all fields and upload image")),
    );
    return;
  }

  final uri = Uri.parse(
      "http://192.168.1.39:3000/api/admin/upload"); // <-- replace with your actual API

  try {
    var request = http.MultipartRequest('POST', uri);

    // Text fields
    request.fields['title'] = _titleController.text;
    request.fields['date'] = _dateController.text;
    request.fields['latitude'] = _latController.text;
    request.fields['longitude'] = _longController.text;
    request.fields['description'] = _descriptionController.text;

    // Image file
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      _pickedImage!.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    // Send request
    var response = await request.send();

    if (response.statusCode == 200) {
      var respStr = await response.stream.bytesToString();
      var jsonResponse = json.decode(respStr);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'] ?? 'Upload successful!')),
      );

      // clear form after success
      _titleController.clear();
      _dateController.clear();
      _latController.clear();
      _longController.clear();
      _descriptionController.clear();
      setState(() => _pickedImage = null);
    } else {
      var respStr = await response.stream.bytesToString();
      print("Upload failed: $respStr");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed: ${response.statusCode}")),
      );
    }
  } catch (e) {
    print("Error uploading: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Upload Image Box
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.lightBlue, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _pickedImage == null
                    ? const Center(
                        child: Icon(Icons.cloud_upload,
                            color: Colors.lightBlue, size: 60),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(_pickedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            TextField(
              controller: _titleController,
              decoration: _inputDecoration("Title"),
            ),
            const SizedBox(height: 12),

            // Date Picker
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: _pickDate,
              decoration: _inputDecoration("Select Date").copyWith(
                suffixIcon: const Icon(Icons.calendar_today, color: Colors.lightBlue),
              ),
            ),
            const SizedBox(height: 12),

            // Coordinates
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latController,
                    decoration: _inputDecoration("Latitude"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _longController,
                    decoration: _inputDecoration("Longitude"),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: _inputDecoration("Description"),
            ),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Submit", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
      ),
    );
  }
}
