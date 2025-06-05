import 'package:ecopos/config/ColorConfig.dart';
import 'package:ecopos/main/bloc/profile/profile_bloc.dart';
import 'package:ecopos/pages/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final user = state.profile;
          return Scaffold(
            appBar: AppBar(title: Text("Profile"), backgroundColor: ColorConfig.bgLight,),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(user.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(user.role, style: TextStyle(fontSize: 16)),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditProfileScreen(user)),
                    ),
                    child: Text("Edit Profile"),
                  ),
                  SizedBox(height: 20),
                  infoRow("Email", user.email),
                  infoRow("Outlet ID", user.outletId),
                  infoRow("Password", "********"),
                  infoRow("Password Confirmation", "********"),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // logout logic
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Logout"),
                  )
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }
}
