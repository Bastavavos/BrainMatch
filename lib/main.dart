// import 'package:brain_match/ui/screens/login.dart';
// import 'package:brain_match/ui/screens/main_layout.dart';
// import 'package:brain_match/ui/screens/register.dart';
import 'package:brain_match/ui/screens/auth/login.dart';
import 'package:brain_match/ui/screens/main_layout.dart';
import 'package:brain_match/ui/screens/quiz_page.dart';
import 'package:brain_match/ui/screens/quiz_screen.dart';
import 'package:brain_match/ui/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:brain_match/ui/screens/auth/register.dart';
import 'package:brain_match/ui/screens/main_layout.dart';
import 'package:brain_match/ui/screens/quiz_screen.dart';
import 'package:brain_match/ui/screens/confirmation_mode.dart'; // <-- à créer
import 'package:flutter_dotenv/flutter_dotenv.dart';

// void main() {
//   runApp(ProviderScope(child: MyApp()));
//   dotenv.load(fileName: ".env");
// }

Future<void> main() async {
  dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainMatch',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/confirm') {
          final selectedMode = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ConfirmationMode(selectedMode: selectedMode),
          );
        }

        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => LoginPage());
          case '/register':
            return MaterialPageRoute(builder: (_) => RegisterPage());
          case '/main':
            return MaterialPageRoute(builder: (_) => MainLayout());
          case '/solo':
            return MaterialPageRoute(builder: (_) => QuizQuestionPage()); // ou ta page solo
          case '/versus':
            return MaterialPageRoute(builder: (_) => QuizQuestionPage()); // ou ta page versus
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(child: Text('Page not found')),
              ),
            );
        }
      },
    );
  }
}



// void main() {
//   runApp(MyApp());
//   // runApp(ProviderScope(child:MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BrainMatch',
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/', // start here
//       routes: {
//         '/': (context) => LoginPage(),
//         '/register': (context) => RegisterPage(),
//         '/main': (context) => MainLayout(),
//       },
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BrainMatch',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
//       ),
//       home: QuizScreen(),
//     );
//   }
// }


