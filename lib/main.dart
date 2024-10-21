// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';

import 'theme/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Teams Clone',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: AppColors.textColor), // Updated
            bodyMedium: TextStyle(color: AppColors.textColor), // Updated
            headlineLarge: TextStyle(
                color: AppColors.primaryColor), // Updated for AppBar title
          ),
          // Add other theme properties as needed
        ),
        home: HomeScreen(),
      ),
    );
  }
}
