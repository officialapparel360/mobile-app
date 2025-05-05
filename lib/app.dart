import 'package:apparel_360/presentation/screens/catelog/bloc/catelog_bloc.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_bloc.dart';
import 'package:apparel_360/presentation/screens/splash_screen.dart';
import 'package:apparel_360/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/service_locator.dart';
import 'core/services/signalRCubit.dart';


class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignalRCubit()),
        BlocProvider(
          create: (context) => ChatBloc(ChatInitialState(), signalRCubit: context.read<SignalRCubit>()),
        ),
        BlocProvider(
          create: (context) => CatelogBloc(CatelogInitial()),
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
        home:  const SplashScreen(),
      ),
    );
  }
}