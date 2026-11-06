import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/Screens/f_account/c_edit_profile_screen/edit_profile_screen.dart';
import 'package:insta_clone2/Screens/f_account/account_widgets/profile_buttons.dart';
import 'package:insta_clone2/Screens/f_account/c_saved_screen/saved_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileButtonsHead extends StatefulWidget {
  const ProfileButtonsHead({super.key});

  @override
  State<ProfileButtonsHead> createState() => _ProfileButtonsHeadState();
}

class _ProfileButtonsHeadState extends State<ProfileButtonsHead> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: profileButtons(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Get.to(EditProfileScreen());
                },
              ),
            ),
          ),
          7.widthBox,
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: profileButtons(
                child: Text(
                  'Share Profile',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  _showShareBottomSheet(context);
                },
              ),
            ),
          ),
          7.widthBox,
          SizedBox(
            width: 45,
            child: profileButtons(
              child: Icon(
                Icons.bookmark_border_sharp,
                size: 22,
                color: Colors.black87,
              ),
              onPressed: () {
                Get.to(SavedScreen());
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          //color: Colors.white70,
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Instagram-style drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  'Share Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //_buildShareOption(Icons.message, 'Message'),
                    _buildShareOption(Icons.qr_code, 'QR Code'),
                    _buildShareOption(Icons.copy, 'Copy Link'),
                    _buildShareOption(Icons.share, 'More'),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, size: 24, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
