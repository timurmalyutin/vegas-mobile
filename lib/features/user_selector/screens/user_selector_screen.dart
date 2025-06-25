import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_colors.dart';

enum UserMode { prelogin, postlogin, postloginWithGroup }

class UserSelectorScreen extends StatelessWidget {
  const UserSelectorScreen({super.key});

  void _selectMode(BuildContext context, UserMode mode) {
    context.push('/promotions', extra: mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, 'Prelogin', UserMode.prelogin),
            _buildButton(context, 'Postlogin', UserMode.postlogin),
            _buildButton(context, 'Postlogin (teszt group)', UserMode.postloginWithGroup),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, UserMode mode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.main,
          foregroundColor: AppColors.dark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        onPressed: () => _selectMode(context, mode),
        child: Text(label),
      ),
    );
  }
}
