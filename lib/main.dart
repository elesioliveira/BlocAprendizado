import 'package:flutter/material.dart';
import 'package:flutter_application_cubit/homePage/cubit/screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homePage/home_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ScreenCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ));
  }
}
