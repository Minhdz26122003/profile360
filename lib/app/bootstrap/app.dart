import 'package:democart/base/utils/responsive_widget.dart';
import 'package:democart/app/router/app_router.dart';
import 'package:democart/features/cart/presentation/blocs/cart_list/cart_list_bloc.dart';
import 'package:democart/features/cart/presentation/cubit/scanner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoCartApp extends StatelessWidget {
  const DemoCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartListBloc>(create: (context) => CartListBloc()),
        BlocProvider<ScannerCubit>(create: (context) => ScannerCubit()),
      ],
      child: MaterialApp(
        title: 'Giỏ Hàng Lễ Tân',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0F52BA),
            primary: const Color(0xFF0F52BA),
          ),
        ),
        builder: (context, child) {
          Responsive.init(context);
          return child!;
        },
        initialRoute: AppRouter.customerProfile,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
