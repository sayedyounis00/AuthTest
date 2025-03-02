import 'package:flutter/material.dart';
import 'package:new_app/core/DI/service_locator.dart';
import 'package:new_app/core/network/constants.dart';
import 'package:new_app/core/routing/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //get_it init
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.setup();
  //supaBase init
  await Supabase.initialize(
    url: ApiConstats.supaUrl,
    anonKey: ApiConstats.apiKey,
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.register,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
