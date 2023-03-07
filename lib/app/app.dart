import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/blocs/domain/domain_bloc.dart';
import 'package:nexaera_chat/data/repositories/domain_repository.dart';
import '../presentation/constants/theme.dart';
import '../utils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: "AI Interface",
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.appThemeData[AppThemeEnum
            .darkTheme], // Removes touch ripple effect from tappable Material widgets
        routerConfig: context.read<AppRouter>().router);
  }
}
