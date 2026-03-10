import 'package:flutter/material.dart';
import 'router.dart';
import '../core/theme/app_theme.dart';

class CashkuApp extends StatelessWidget {
  const CashkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CashKu',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
