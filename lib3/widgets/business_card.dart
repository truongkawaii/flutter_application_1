import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/business_profile.dart';
import 'package:flutter_application_1/utils/app_colors.dart';

class BusinessCard extends StatelessWidget {
  final BusinessProfile profile;
  const BusinessCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Avatar
            _buildAvatar(),
            const SizedBox(height: 16),
            // Name
            Text(
              profile.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.cardTextColor,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            //Job Title
            _buildJobTitle(),
            const SizedBox(height: 20),
            //Contact Info
            _buildContactInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          profile.avatarUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white,
              child: const Icon(
                Icons.person,
                size: 50,
                color: AppColors.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildJobTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        profile.jobTitle,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.cardTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildContactItem(Icons.email, 'Email'),
        _buildContactItem(Icons.phone, 'Phone'),
        _buildContactItem(Icons.location_on, 'Location'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 11),
        ),
      ],
    );
  }
}
