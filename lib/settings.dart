import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF52C6A9),
      ),
      body: ListView(
        children: [
          _buildSettingItem(context, 'Profile Settings', Icons.person),
          _buildSettingItem(context, 'Notification Settings', Icons.notifications),
          _buildSettingItem(context, 'Theme Settings', Icons.color_lens),
          _buildSettingItem(context, 'Select App Language', Icons.language),
          _buildSettingItem(context, 'Rate Us and Feedback', Icons.rate_review),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF52C6A9)), // Icon for the setting
      title: Text(title),
      trailing: Icon(Icons.chevron_right), // Arrow icon to indicate more settings
      onTap: () {
        // Navigate to respective settings page (not implemented)
        _showSettingActionDialog(context, title);
      },
    );
  }

  void _showSettingActionDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text('Navigate to $title settings.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
