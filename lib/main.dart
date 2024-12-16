


import 'package:flick/pages/customer/PremiumPlan.dart';
import 'package:flick/pages/customer/SelectPlan.dart';
import 'package:flick/pages/forget_pw.dart';
import 'package:flick/pages/homepage.dart';
import 'package:flick/pages/login_page.dart';
import 'package:flick/pages/navigation/admin_nav.dart';
import 'package:flick/pages/navigation/bottom_navigation.dart';
import 'package:flick/pages/paymentmethod.dart';
import 'package:flick/pages/register_screen.dart';
import 'package:flick/pages/server_page.dart';
import 'package:flick/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'database/auth.dart';
import 'database/user.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      StreamProvider<UserModel?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
            routes: {
              '/': (context) => const WelcomePage(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/wrapper': (context) => const Authorize(),
              '/HomePage': (context) => const AdminNavi(index: 0),

              '/order': (context) => const BottomNavigation(index: 1),
              '/payment': (context) => const PremiumPlan(),
              '/checkout': (context) => const CheckoutPage(),


              '/forget': (context) => const ForgetPassword(),


            }
        ),
      );
  }
}

