import 'package:apparel_360/presentation/screens/catelog/bloc/catelog_bloc.dart';
import 'package:apparel_360/presentation/screens/dashboard/bloc/chat_bloc.dart';
import 'package:apparel_360/presentation/screens/dashboard/dashboard.dart';
import 'package:apparel_360/presentation/screens/login.dart';
import 'package:apparel_360/presentation/screens/splash_screen.dart';
import 'package:apparel_360/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/prefernce/shared_preference.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => CatelogBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'Fashion Factory',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}