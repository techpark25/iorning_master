import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

import 'presentation/splash/splash_screen.dart';
import 'navigation/route_generator.dart';
import 'viewmodels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");

  runApp(const MyApp()); // Start your app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...viewmodelProviders],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerator.initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
