import 'package:bloc_to_communication/app.dart';
import 'package:bloc_to_communication/bloc/license_bloc.dart';
import 'package:bloc_to_communication/bloc/product_bloc.dart';
import 'package:bloc_to_communication/repository/license_repository.dart';
import 'package:bloc_to_communication/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ProductRepository()),
          RepositoryProvider(create: (context) => LicenseRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductBloc(
                context.read<ProductRepository>(),
                context.read<LicenseRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) =>
                  LicenseBloc(context.read<LicenseRepository>()),
            ),
          ],
          child: const App(),
        ),
        // child: BlocProvider(
        //   create: (context) => ProductBloc(context.read<ProductRepository>()),
        //   child: Builder(builder: (context) {
        //     return BlocProvider(
        //       create: (context) => LicenseBloc(
        //         context.read<LicenseRepository>(),
        //         context.read<ProductBloc>(),
        //       ),
        //       child: const App(),
        //     );
        //   }),
        // ),
      ),
    );
  }
}
