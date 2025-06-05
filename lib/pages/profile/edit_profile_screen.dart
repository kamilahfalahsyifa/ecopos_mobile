import 'package:ecopos/config/ColorConfig.dart';
import 'package:ecopos/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:ecopos/main/bloc/profile/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile user;
  EditProfileScreen(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController roleController;
  late TextEditingController outletIdController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    roleController = TextEditingController(text: widget.user.role);
    outletIdController = TextEditingController(text: widget.user.outletId);
    passwordController = TextEditingController(text: widget.user.password);
    passwordConfirmController = TextEditingController(text: widget.user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"), backgroundColor: ColorConfig.bgLight,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            field("Nama", nameController),
            field("Email", emailController),
            field("Role", roleController),
            field("Outlet ID", outletIdController),
            field(
              "Password",
              passwordController,
              isPassword: true,
              obscureText: _obscurePassword,
              toggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            field(
              "Password Confirmation",
              passwordConfirmController,
              isPassword: true,
              obscureText: _obscureConfirm,
              toggleVisibility: () {
                setState(() {
                  _obscureConfirm = !_obscureConfirm;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text == passwordConfirmController.text) {
                  final updatedUser = UserProfile(
                    name: nameController.text,
                    email: emailController.text,
                    role: roleController.text,
                    outletId: outletIdController.text,
                    password: passwordController.text,
                  );
                  context.read<ProfileBloc>().add(UpdateProfile(updatedUser));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password confirmation does not match")),
                  );
                }
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }

  Widget field(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
