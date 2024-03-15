import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileSettingsScreen extends StatefulWidget {
  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && _passwordController.text.isNotEmpty) {
          await user.updatePassword(_passwordController.text);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password changed successfully')));
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 50);
    Navigator.of(context).pop(); // Dismiss the bottom sheet
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
      _uploadProfilePicture(pickedFile);
    }
  }

  
  Future<void> _uploadProfilePicture(XFile image) async {
  print("Uploading file: ${image.path}"); // Debugging line
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('profile_pictures/${user.uid}/profile_pic.jpg');

    try {
      await ref.putFile(File(image.path));
      final downloadUrl = await ref.getDownloadURL();
      print("Download URL: $downloadUrl"); // Debugging line
      await user.updateProfile(photoURL: downloadUrl);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture uploaded successfully')));
    } on firebase_storage.FirebaseException catch (e) {
      print("Error uploading image: ${e.message}"); // Debugging line
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image: ${e.message}')));
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        backgroundColor: Color(0xFF23272E), // Main color for AppBar
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_imageFile != null)
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(_imageFile!.path)),
                ),
              )
            else
              GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.add_a_photo, color: Colors.grey[800]),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showImageSourceActionSheet(context),
              child: Text('Change Profile Photo'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // Button background
                onPrimary: Colors.white, // Button text color
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Please enter a new password with at least 6 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF23272E), // Button color
              ),
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
