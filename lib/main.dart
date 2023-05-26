import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/cubitAddFood/addFood.dart';
import 'package:flutter_application_1/app_screens/category.dart';
import 'package:flutter_application_1/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'admin/adminHome.dart';
import 'app_screens/widget/buttom_navigationbar.dart';
import 'cashe.dart';
import 'app_screens/componen/cart.dart';
import 'app_screens/listing.dart';
import 'bording/on_bording.dart';
import 'cubit/cubit.dart';

String? uIdAdmin;
String? uIdCustomer;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uIdAdmin = CacheHelper.getData(key: 'uIdAdmin');
  uIdCustomer = CacheHelper.getData(key: 'uIdCustomer');
  Widget widget;
  if (uIdAdmin != null) {
    widget = adminHome();
  } else if (uIdCustomer != null) {
    widget = ButtomNavigationBar();
  } else {
    widget = OnBoarding();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        BlocProvider(create: (BuildContext context) => AppCubit()),
      ],
      child: MaterialApp(
        routes: {
          '/listing_screen': (context) => FoodListingBody(),
          '/login': (context) => SocialLoginScreen(),
          '/Search': ((context) => FoodListingBody())
        },
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
