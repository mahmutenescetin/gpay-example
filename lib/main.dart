import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/dashboard_view/dashboard_view.dart';
import 'view/home_view/home_view_model.dart';
import 'view/profile_view/profile_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeViewModel.instance),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DashboardView(),
    );
  }
}
