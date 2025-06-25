import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'router.dart';
import 'themes.dart';

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vegas Mobile',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 349, name: 'SMALL'),
            const Breakpoint(start: 350, end: 599, name: MOBILE),
            const Breakpoint(start: 600, end: 1023, name: TABLET),
            const Breakpoint(start: 1024, end: double.infinity, name: DESKTOP),
          ],
        );
      },
    );
  }
}
