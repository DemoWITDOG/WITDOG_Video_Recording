import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:witdog_recodtester/presentation/utils/constants.dart';
import 'package:witdog_recodtester/presentation/view/pet_add_view.dart';
import 'package:witdog_recodtester/presentation/view/record_home_view.dart';
import 'package:witdog_recodtester/presentation/view/user_login_view.dart';

Future<void> main() async {
  Logger.level = Level.debug;
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PetAddView(),
    );
  }
}