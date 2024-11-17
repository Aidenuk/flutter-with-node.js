import 'package:clone_carrot/home/screen/home_screen.dart';
import 'package:clone_carrot/provider/user_provider.dart';
import 'package:clone_carrot/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/global_variables.dart';
import 'features/auth/screens/auth_screen.dart';
import 'router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chang Market',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ))),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomeScreen()
          : const AuthScreen(),
    );
  }
}
