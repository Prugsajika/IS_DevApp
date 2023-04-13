import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maget_app/pages/login_page.dart';
import 'package:maget_app/pages/detailproduct_page.dart';
import 'package:provider/provider.dart';
import 'components/restaurant_appbar.dart';
import 'firebase_options.dart';

import 'pages/favourite_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen(
    (User? user) {
      if (user == null) {
        print('User is currently signed out!');
        //Do something when user logged out.
      } else {
        print('User is signed in!');
        //TODD to load user_profile with email from firebase_auth
      }
    },
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileDetailModel()),
      ],
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.amber[100],
      ),
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => LoginPage(),
        '/1': (context) => HomePage(),
        '/2': (context) => RegisterPage(),
        '/3': (context) => ProfilePage(),
        '/4': (context) => FavouritesPage(),
        '/5': (context) => RestaurantAppBar(),
        '/6': (context) => DetailProductPage(),
        '/7': (context) => DetailProductPage(),
      },
    );
  }
}
