import 'package:chat_app/core/services/web_socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chat_app/core/services/app_bloc_observer.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repositories.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:chat_app/features/chat/view/blocs/chat_bloc.dart';
import 'package:chat_app/features/chat/data/models/message.dart';
import 'package:chat_app/firebase_options.dart';

final AuthRepositories repositories = AuthRepositories();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WebSocketServices.getInstance(
    "wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1",
  );

  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(MessageAdapter());
  await Hive.openBox<Message>('chatBox');

  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(repositories),
        ),
        BlocProvider(
          create: (context) => ChatBloc()..add(ChatEvent.fetchChat()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
