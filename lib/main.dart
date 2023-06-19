import 'package:daily_driver/firebase_options.dart';
import 'package:daily_driver/router/routes.dart';
import 'package:daily_driver/state_manager/buttons_state.dart';
import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoaderState>(
        create: (context) => LoaderState(),
      ),
      ChangeNotifierProvider<ButtonState>(create: (context) => ButtonState())
    ],
    child: MaterialApp.router(
      routerConfig: PageRoutes.goRoute,
    ),
  ));
}
