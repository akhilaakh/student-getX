// import 'package:flutter/material.dart';
// import 'package:student_app/screens/myHome_page.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     GoToDataScreen();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Image.asset(
//             "assets/Students Celebrate Graduation Illustration concept on white background (1).jpeg",
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> GoToDataScreen() async {
//     await Future.delayed(Duration(seconds: 3));
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (ctx) => HomeScreen(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:student_app/screens/myHome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    GoToDataScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/download (2).jpeg",
              width: 1000,
              // height: 150,
              // fit: BoxFit.contain,
            ),
            Image.asset(
              "assets/Students Celebrate Graduation Illustration concept on white background (1).jpeg",
              width: 550,
              // height: 400,
            ),
            // SizedBox(height: 1),
            Image.asset(
              "assets/download (3).jpeg",
              width: 1000,
              // height: 200,
              // fit: BoxFit.contain,
            ),
            // SizedBox(height: 20),
            Image.asset(
              "assets/download (2).jpeg",
              width: 550,
              // height: 150,
              // fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> GoToDataScreen() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomeScreen(),
      ),
    );
  }
}
