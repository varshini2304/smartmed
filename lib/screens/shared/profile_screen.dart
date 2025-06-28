import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String role; // "Doctor" or "Patient"

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('My Profile'),
        backgroundColor: primaryColor,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: Add Firebase signOut
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Chip(
                  label: Text(
                    role,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.security,
                        color: primaryColor,
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: primaryColor.withOpacity(0.6),
                      ),
                      onTap: () {
                        // TODO: Navigate to privacy screen
                      },
                    ),
                    Divider(
                      height: 1,
                      color: primaryColor.withOpacity(0.2),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help_outline,
                        color: primaryColor,
                      ),
                      title: Text(
                        'Help & Support',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: primaryColor.withOpacity(0.6),
                      ),
                      onTap: () {
                        // TODO: Navigate to support screen
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}