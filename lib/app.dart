import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_bloc.dart';
import 'package:apparel_360/presentation/screens/dashboard/home-component/home_screen.dart';
import 'package:apparel_360/presentation/screens/authentication/login_screen.dart';
import 'package:apparel_360/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(ChatInitialState())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'Fashion Factory',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
